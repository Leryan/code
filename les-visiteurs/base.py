class Visitor:
    def visitPK(self, pk):
        raise NotImplementedError(
            f'missing {self.__class__}.visitPK(acceptor) implementation'
        )

    def visitEstimations(self, estimations):
        raise NotImplementedError('')


class Acceptor:
    def accept(self, visitor: Visitor):
        raise NotImplementedError(
            f'missing {self.__class__}.accept(visitor) implementation'
        )
