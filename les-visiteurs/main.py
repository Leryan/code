#!/usr/bin/env python


import django


def main():

    backend = django.Backend()
    dm = backend.fetch_model(10)
    visitor = django.ToDictVisitor()
    dm.accept(visitor)

    print(visitor.serialized)


if __name__ == '__main__':
    main()
