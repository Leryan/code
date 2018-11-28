from caching.exceptions import SerializeError

class Serializer:

    def serialize(self, identifier, value):
        """
        :raises SerializeError:
        """
        return {'id': identifier, 'value': value}

    def deserialize(self, identifier, value):
        """
        :raises DeserializeError:
        """
        if value['id'] == identifier:
            return value['value']
        else:
            raise SerializeError('id {identifier} does not match value[\'id\']}')

