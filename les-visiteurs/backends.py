from mtypes import ID

from django import DjangoPK, DjangoEstimations, DjangoModel


class Base:
    def fetch_model(self, id_: ID):
        raise NotImplementedError(f'missing {self.__class__}.fetch_model implementation')


class Django(Base):
    def fetch_model(self, id_: ID) -> DjangoModel:
        pk = DjangoPK(id_)
        ests = list(range(0 + id_, 5 + id_))
        estimations = DjangoEstimations(ests)
        return DjangoModel(pk, estimations)
