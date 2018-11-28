class NoData(Exception):
    pass

class NoCacheData(NoData):
    pass

class NoRemoteData(NoData):
    pass

class SerializeError(Exception):
    pass

class DeserializeError(Exception):
    pass

