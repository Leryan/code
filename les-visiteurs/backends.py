from mtypes import TID
from base import err_msg


class Base:
    def fetch_model(self, id_: TID):
        raise NotImplementedError(err_msg(self, 'fetch_model'))
