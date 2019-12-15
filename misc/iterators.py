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
        self._collections = (x for x in args)
        self.__next_cit()

    def __next_cit(self):
        self._cit = (x for x in next(self._collections))

    def __iter__(self):
        return self

    def __next__(self):
        try:
            return next(self._cit)
        except StopIteration:
            self.__next_cit()
            return next(self._cit)

i = IterMulti([0, 1], [2, 3], [4, 5, 6], (x for x in [7, 8, 9]))
for b in i:
    print(b)
