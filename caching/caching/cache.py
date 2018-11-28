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

def dec_get(prepend_identifier='', build_identifier=lambda x, y: x+y):
    def w(func):
        def wrap(self, identifier, *args, **kwargs):
            bi = build_identifier(prepend_identifier, identifier, *args, **kwargs)
            print('cache => execute cache')
            try:
                rc = self._cache.get(bi)
                print('cache ==> got cached value')
                return rc
            except NoCacheData:
                pass
            print('cache ==> no cached value, asking remote')
            rb = func(self, identifier, *args, **kwargs)
            print('cache ==> remote has value, caching')
            self._cache.set(bi, rb)
            return rb
        return wrap
    return w

def dec_set(prepend_identifier='', build_identifier=lambda x, y: x+y):
    def w(func):
        def wrap(self, identifier, value, *args, **kwargs):
            r = func(self, identifier, value, *args, **kwargs)
            print('cache => set in remote ok, caching')
            bi = build_identifier(prepend_identifier, identifier, *args, **kwargs)
            self._cache.set(bi, value)
            return r
        return wrap
    return w

def dec_drop(prepend_identifier='', build_identifier=lambda x, y: x+y):
    def w(func):
        def wrap(self, identifier, *args, **kwargs):
            print('cache => drop')
            bi = build_identifier(prepend_identifier, identifier, *args, **kwargs)
            self._cache.drop(bi)
            print('cache => drop remote')
            return func(self, identifier, *args, **kwargs)
        return wrap
    return w
