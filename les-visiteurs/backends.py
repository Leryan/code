from mtypes import ID


class Base:
    def fetch_model(self, id_: ID):
        raise NotImplementedError(f'missing {self.__class__}.fetch_model implementation')
