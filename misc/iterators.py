from collections import defaultdict

def merge(data, masterkey='superkey'):
    """
    :param list[dict] data:
    """
    aggreg = defaultdict(dict)
    for doc in filter(lambda x: masterkey in x, data):
        aggreg[doc[masterkey]].update(doc)
    return [aggreg[id_] for id_ in aggreg.keys()]

left = [
    {'a': 1, 'b': 2, 'superkey': 'id'},
    {'e': 5, 'f': 6, 'superkey': 'id'},
    {'B': 2, 'superkey': 'prout'}
]
right = [
    {'c': 3, 'd': 4, 'superkey': 'id'},
    {'A': 1, 'superkey': 'prout'},
    {'error': 'no key superkey'}
]
left.extend(right)
print(merge(left))

class IterMulti:

    def __init__(self, *args):
        """
        :param iterators *args
        """
        self._collections = args
        self._cc = 0

        self.__next_cit()

    def __next_cit(self):
        self._cc += 1
        try:
            self._cit = self._collections[self._cc - 1]
        except IndexError:
            raise StopIteration
        self._citi = 0

    def __iter__(self):
        return self

    def __next__(self):
        try:
            v = self._cit[self._citi]
            self._citi += 1
            return v
        except IndexError:
            self.__next_cit()
            return next(self)

i = IterMulti([0, 1], [2, 3], [4, 5, 6])
for b in i:
    print(b)
