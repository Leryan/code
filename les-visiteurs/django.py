from typing import List

from mtypes import ID, Estimations
from base import Acceptor, Visitor
from serializers import Serializer


class DjangoPK(Acceptor):

    id_: ID

    def __init__(self, id_: ID):
        self.id_ = id_

    def accept(self, visitor: Visitor):
        visitor.visitID(self)


class DjangoEstimations(Acceptor):

    estimations: Estimations

    def __init__(self, estimations: Estimations):
        self.estimations = estimations

    def accept(self, visitor: Visitor):
        visitor.visitEstimations(self)


class DjangoModel(Acceptor):

    pk: DjangoPK
    estimations: DjangoEstimations

    def __init__(self, pk: DjangoPK, estimations: DjangoEstimations):
        self.pk = pk
        self.estimations = estimations

    def accept(self, visitor: Visitor):
        self.pk.accept(visitor)
        self.estimations.accept(visitor)


class DjangoVisitor(Visitor):
    def __init__(self, serializer: Serializer):
        self._ser = serializer

    def visitID(self, mID: DjangoPK):
        self._ser.serialize('id', mID.id_)

    def visitEstimations(self, mEstimations: DjangoEstimations):
        self._ser.serialize('estimations', mEstimations.estimations)
