from base import Visitor
from typing import DefaultDict
from models import Estimations, Product, Data, ID
from collections import defaultdict


class ElasticSearchSerializer(Visitor):
    @property
    def serialized(self):
        return self._dict

    def __init__(self, on_index=None):
        self._dict = {'_source': {}}

        if on_index:
            self._dict['_index'] = on_index

        self._pddl: DefaultDict[str, TData] = defaultdict(list)

    def visitID(self, mID: ID):
        self._dict['_id'] = mID.id_

    def visitEstimations(self, mEstimations: Estimations):
        self._dict['_source']['estimations'] = mEstimations.estimations

    def visitProduct(self, mProduct: Product):
        for mpd in mProduct.data:
            mpd.accept(self)

        self._dict['_source']['product__data'] = dict(self._pddl)

    def visitData(self, mData: Data):
        self._pddl[mData.key].append(mData.data)
