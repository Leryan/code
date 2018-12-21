class Serializer:
    @property
    def serialized(self):
        raise NotImplementedError(
            f'missing {self.__class__}.serialized property implementation'
        )

    def serialize(self, attr, value):
        raise NotImplementedError(
            f'missing {self.__class__}.serialize(attr, value) implementation'
        )


class ToDict(Serializer):
    @property
    def serialized(self):
        return self._data

    def __init__(self):
        self._data = {}

    def serialize(self, attr, value):
        self._data[attr] = value
