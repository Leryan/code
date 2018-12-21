from typing import List, DefaultDict
from collections import defaultdict

from mtypes import TID, TEstimations, TData
from base import Acceptor, Visitor
from backends import Base as BaseBackend
from mocks import mock_model
from models import Model


class Backend(BaseBackend):
    def fetch_model(self, id_: TID) -> Model:
        return mock_model(id_)
