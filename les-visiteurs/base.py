def err_msg(obj, method_name):
    return f'missing {self.__class__.__name__}.{method_name} implementation'


class Visitor:
    def visitID(self, pk):
        raise NotImplementedError(err_msg(self, 'visitID'))

    def visitEstimations(self, estimations):
        raise NotImplementedError(err_msg(self, 'visitEstimations'))

    def visitProduct(self, product):
        raise NotImplementedError(err_msg(self, 'visitProduct'))


class Acceptor:
    def accept(self, visitor: Visitor):
        raise NotImplementedError(
            f'missing {self.__class__}.accept(visitor) implementation'
        )
