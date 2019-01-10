from contextlib import suppress

class Bla:

    def __enter__(self):
        print('enter context')

    def __exit__(self, type_, value, traceback):
        if traceback:
            print('exit with exception: {}', traceback)
        else:
            print('exit successfuly')

b = Bla()

print('==== Exception')
with suppress(Exception):
    with b:
        raise Exception('prout')

print('==== OK')
with b:
    print('pwet')
