import inspect

def blabla(ctx):
    print(f"context created at: {ctx.finfo.filename}#L{ctx.finfo.lineno}")

class Context:

    def __enter__(self):
        frame = inspect.currentframe()
        self.finfo = inspect.getouterframes(frame, context=1)[1]
        return self

    def __exit__(self, *args, **kwargs):
        pass

# This is a comment
with Context() as c:
    blabla(c)
