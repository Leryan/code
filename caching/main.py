from caching.serializers import Serializer
from caching.cache import Cache

from app import Controller
from backend import Backend

if __name__ == '__main__':
    c = Controller(Backend({}, Cache(Serializer())))
    c.i_do_stuff()
