# Go CoolTypes

When some types are missing in Go, you can use `CoolTypes`.

## Usage

```
go get -u github.com/Leryan/go-cooltypes/cooltypes
```

```go
import "github.com/Leryan/go-cooltypes/cooltypes"
```

## Examples

### PyMap

Simplifies `map` access in Go. Python code:

```python
m = {}
m["counter"] = m.get("counter", 0) + 1
```

Using `PyMap`:

```go
m := NewPyMap()
m["counter"] = m.GetDef("counter", 0).(int) + 1
```

Using a regular `map`:

```go
m := make(map[string]int)

if val, exists := m["counter"]
if exists {
    m["counter"] = val + 1
} else {
    m["counter"] = 0
}
```

#### Performance

Due to the use of `interface{}`, `PyMap` **is** slower than a map with concrete types by a factor of 5. If you want to be faster, consider using some code generators like [genny](https://github.com/cheekybits/genny).
