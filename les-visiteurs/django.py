from typing import List, DefaultDict
from collections import defaultdict

from mtypes import TID, TEstimations, TData
from base import Acceptor, Visitor
import backends


class PK(Acceptor):

    id_: TID

    def __init__(self, id_: TID):
        self.id_ = id_

    def accept(self, visitor: Visitor):
        visitor.visitID(self)


class Estimations(Acceptor):

    estimations: TEstimations

    def __init__(self, estimations: TEstimations):
        self.estimations = estimations

    def accept(self, visitor: Visitor):
        visitor.visitEstimations(self)


class Data(Acceptor):

    key: str
    data: str

    def __init__(self, key: str, data: str):
        self.key = key
        self.data = data


class Product(Acceptor):

    data: List[Data]

    def __init__(self, data: List[Data]):
        self.data = data

    def accept(self, visitor: Visitor):
        visitor.visitProduct(self)


class Model(Acceptor):

    pk: PK
    estimations: Estimations
    product: Product

    def __init__(self, pk: PK, estimations: Estimations, product: Product):
        self.pk = pk
        self.estimations = estimations
        self.product = product

    def accept(self, visitor: Visitor):
        self.pk.accept(visitor)
        self.estimations.accept(visitor)
        self.product.accept(visitor)


class ToDictSerializer(Visitor):
    @property
    def serialized(self):
        return self._dict

    def __init__(self):
        self._dict = {}

    def visitID(self, mID: PK):
        self._dict['id'] = mID.id_

    def visitEstimations(self, mEstimations: Estimations):
        self._dict['estimations'] = mEstimations.estimations

    def visitProduct(self, mProduct: Product):
        dl: DefaultDict[str, TData] = defaultdict(list)
        for mpd in mProduct.data:
            dl[mpd.key].append(mpd.data)

        self._dict['product__data'] = dict(dl)


class Backend(backends.Base):
    def fetch_model(self, id_: TID) -> Model:
        pk = PK(id_)
        ests = list(range(0 + id_, 5 + id_))
        estimations = Estimations(ests)
        product = Product([Data('bla', 'blu'), Data('vrac', str(ests))])
        return Model(pk, estimations, product)
