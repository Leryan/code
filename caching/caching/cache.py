from functools import lru_cache

from caching.exceptions import NoCacheData

class NullCache:
    """
    For tests only, if cache isn't required, don't use a cache at all
    in the first place.
    """

    def get(self, identifier):
        raise NoCacheData(identifier)

    def set(self, identifier, value):
        pass

    def drop(self, identifier):
        pass

class Cache:

    def __init__(self, serializer):
        self._s = serializer
        self._cache = {}

    def get(self, identifier):
        try:
            r = self._s.deserialize(identifier, self._cache[identifier])
            print('cache ===> fetched remote cache')
            return r
        except KeyError:
            raise NoCacheData(identifier)

    def set(self, identifier, value):
        self._cache[identifier] = self._s.serialize(identifier, value)

    def drop(self, identifier):
        try:
            del self._cache[identifier]
        except KeyError:
            pass

class LRUCache(Cache):

    def __init__(self, serializer, maxsize=128):
        super().__init__(serializer)
        self.get = lru_cache(maxsize=maxsize)(self.get)

def dec_get(func):
    def wrap(self, identifier):
        print('cache => execute cache')
        try:
            rc = self._cache.get(identifier)
            print('cache ==> got cached value')
            return rc
        except NoCacheData:
            pass
        print('cache ==> no cached value, asking remote')
        rb = func(self, identifier)
        print('cache ==> remote has value, caching')
        self._cache.set(identifier, rb)
        return rb
    return wrap

def dec_set(func):
    def wrap(self, identifier, value):
        r = func(self, identifier, value)
        print('cache => set in remote ok, caching')
        self._cache.set(identifier, value)
        return r
    return wrap

def dec_drop(func):
    def wrap(self, identifier):
        print('cache => drop')
        self._cache.drop(identifier)
        print('cache => drop remote')
        return func(self, identifier)
    return wrap
