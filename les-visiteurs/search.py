from backends import Base as BaseBackend
from mtypes import TID
from mocks import mock_model


class Backend(BaseBackend):
    def fetch_model(self, id_: TID):
        return mock_model(id_)
