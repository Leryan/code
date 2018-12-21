from typing import List

from base import Acceptor, Visitor
from mtypes import TID, TEstimations


class ID(Acceptor):

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

    def accept(self, visitor: Visitor):
        visitor.visitData(self)


class Product(Acceptor):

    data: List[Data]

    def __init__(self, data: List[Data]):
        self.data = data

    def accept(self, visitor: Visitor):
        visitor.visitProduct(self)


class Model(Acceptor):

    id_: ID
    estimations: Estimations
    product: Product

    def __init__(self, id_: ID, estimations: Estimations, product: Product):
        self.id_ = id_
        self.estimations = estimations
        self.product = product

    def accept(self, visitor: Visitor):
        self.id_.accept(visitor)
        self.estimations.accept(visitor)
        self.product.accept(visitor)
