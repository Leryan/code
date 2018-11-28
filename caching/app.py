from caching.exceptions import NoRemoteData

class Controller:

    def __init__(self, backend):
        self._b = backend

    def i_do_stuff(self):
        try:
            self._b.get('myid')
        except NoRemoteData:
            print('control => perfect, got no data')

        print('control => setting value')
        self._b.set('myid', 'myvalue')
        print('control => getting value back')
        value = self._b.get('myid')
        print(f'control => got value: "{value}"')

        print('control => getting value (cached?) back')
        value = self._b.get('myid')
        print(f'control => got value: "{value}"')

        self._b.drop('myid')

        print('control => getting value back')
        try:
            value = self._b.get('myid')
            print(f'control => got value: "{value}"')
        except NoRemoteData:
            print('control => perfect, data was dropped')

