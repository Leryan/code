from caching.serializers import Serializer
from caching.cache import NullCache, Cache, LRUCache

from app import Controller
from backend import Backend

if __name__ == '__main__':
    print('No cache')
    c = Controller(Backend({}, NullCache()))
    c.i_do_stuff()

    print('Regular cache')
    c = Controller(Backend({}, Cache(Serializer())))
    c.i_do_stuff()

    print('LRU cache')
    c = Controller(Backend({}, LRUCache(Serializer())))
    c.i_do_stuff()
