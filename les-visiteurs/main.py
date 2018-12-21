#!/usr/bin/env python


import django
import visitors


def main():

    backend = django.Backend()
    dm = backend.fetch_model(10)
    visitor = visitors.ToDictSerializer()
    dm.accept(visitor)

    print(visitor.serialized)


if __name__ == '__main__':
    main()
