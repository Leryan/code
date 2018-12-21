#!/usr/bin/env python


from django import *
from backends import Django
from serializers import ToDict


def main():

    backend = Django()
    dm = backend.fetch_model(10)
    serializer = ToDict()
    visitor = DjangoVisitor(serializer)
    dm.accept(visitor)

    print(serializer.serialized)


if __name__ == '__main__':
    main()
