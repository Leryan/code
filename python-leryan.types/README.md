# Python leryan.types

[![Build Status](https://travis-ci.org/Leryan/leryan.types.svg?branch=master)](https://travis-ci.org/Leryan/leryan.types) [![Documentation Status](https://readthedocs.org/projects/leryantypes/badge/?version=latest)](http://leryantypes.readthedocs.org/en/latest/?badge=latest) [![Code Health](https://landscape.io/github/Leryan/leryan.types/master/landscape.svg?style=flat)](https://landscape.io/github/Leryan/leryan.types/master)

```bash
pip install leryan.types
```

## ObjectDict

```python
from leryan.types import ObjectDict

od = ObjectDict({'yolo': '1337'})

# prints '1337'
print(od.yolo)
```

## FastEnum

```python
from leryan.types import FastEnum

class MyEnum(FastEnum)

    MEMBER = 'value'

# 'value'
print(MyEnum.MEMBER)

# ('MEMBER',)
print(MyEnum.members)

# ('value',)
print(MyEnum.values)
```

## SimpleConf

```python
from leryan.types.simpleconf import SimpleConf, Ini, Json

sconf = """
[section]
key = value
"""

ini_config = SimpleConf.export(Ini(sconf=sconf))
assert ini_config.section.key == 'value'


sconf = """
{
    "section": {
        "key": "value"
    }
}
"""

with open('/path/to/config.json', 'w') as fh:
    fh.write(sconf)

with open('/path/to/config.json', 'r') as fh:
    json_config = SimpleConf.export(Json(fh=fh))
    assert json_config.section.key == 'value'
```

## Testing

Install python 2.7, 3.4, 3.5 and 3.6 interpreters then run tests with [tox](https://tox.readthedocs.io/en/latest/).
