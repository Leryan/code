from mtypes import TID
from models import Estimations, Data, Product, ID, Model


def mock_model(id_: TID):
    mid = ID(id_)
    ests = list(range(0 + id_, 5 + id_))
    estimations = Estimations(ests)
    product = Product([Data('bla', 'blu'), Data('vrac', str(ests))])
    return Model(mid, estimations, product)
