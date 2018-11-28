from functools import lru_cache

from caching.exceptions import NoCacheData

class Cache:

    def __init__(self, serializer):
        self._s = serializer
        self._cache = {}

    def get(self, identifier):
        try:
            return self._s.deserialize(identifier, self._cache[identifier])
        except KeyError:
            raise NoCacheData(identifier)

    def set(self, identifier, value):
        self._cache[identifier] = self._s.serialize(identifier, value)

    def drop(self, identifier):
        try:
            del self._cache[identifier]
        except KeyError:
            pass

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
