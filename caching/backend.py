from caching.exceptions import NoRemoteData, NoCacheData
from caching import cache

class Backend:

    def __init__(self, store, cache):
        self._store = store
        self._cache = cache

    @cache.dec_get()
    def get(self, identifier):
        return self.get_nocache(identifier)

    def get_nocache(self, identifier):
        try:
            print('backend => get?')
            return self._store[identifier]
        except KeyError:
            print('backend ==> no data')
            raise NoRemoteData(identifier)

    @cache.dec_set()
    def set(self, identifier, value):
        return self.set_nocache(identifier, value)

    def set_nocache(self, identifier, value):
        self._store[identifier] = value
        print('backend => set')

    @cache.dec_drop()
    def drop(self, identifier):
        try:
            del self._store[identifier]
        except KeyError:
            pass
        print('backend => dropped')

    def complex_get(self, crit1, crit2, crit3):
        cid = f'{crit1}{crit2}{crit3}'
        try:
            return self._cache.get(cid)
        except NoCacheData:
            r = self.get_nocache(crit1) + self.get_nocache(crit2) + self.get_nocache(crit3)
            self._cache.set(cid, r)
            return r
