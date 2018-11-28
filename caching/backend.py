from caching.exceptions import NoRemoteData
from caching import cache

class Backend:

    def __init__(self, store, cache):
        self._store = store
        self._cache = cache

    @cache.dec_get
    def get(self, identifier):
        try:
            print('backend => get?')
            return self._store[identifier]
        except KeyError:
            print('backend ==> no data')
            raise NoRemoteData(identifier)

    @cache.dec_set
    def set(self, identifier, value):
        self._store[identifier] = value
        print('backend => set')

    @cache.dec_drop
    def drop(self, identifier):
        try:
            print('backend => dropped')
            del self._store[identifier]
        except KeyError:
            pass

