from base import Visitor
from typing import DefaultDict
from models import Estimations, Product, Data, ID
from collections import defaultdict


class ToDictSerializer(Visitor):
    @property
    def serialized(self):
        return self._dict

    def __init__(self):
        self._dict = {}
        self._pddl: DefaultDict[str, TData] = defaultdict(list)

    def visitID(self, mID: ID):
        self._dict['id'] = mID.id_

    def visitEstimations(self, mEstimations: Estimations):
        self._dict['estimations'] = mEstimations.estimations

    def visitProduct(self, mProduct: Product):
        for mpd in mProduct.data:
            mpd.accept(self)

        self._dict['product__data'] = dict(self._pddl)

    def visitData(self, mData: Data):
        self._pddl[mData.key].append(mData.data)
