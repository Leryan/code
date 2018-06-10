# Vocabulary

 * `mypolicy.te`: policy module source file. `te` stands for `Type Enforcement`.
 * `mypolicy.pp`: binary policy module file
 * `mypolicy.fc`: file context source file.

# Basic policy

mypolicy.te structure:

```
module <name> <version>;
require {
    type some_type_t;
    type another_type_t;
    ...;
}

allow some_type_t another_type_t:dir { read search };
```

mypolicy.fc structure:

```
/path(regex)<tab>optional classes<tab>context
# dumb example
/opt/test	system_u:object_r:var_t
```

 * `<name>`: for example `mypolicy`
 * `<version>`: for example `0.0.1`

# Commands

Source to module:

```bash
checkmodule -M -m -o mypolicy.mod mypolicy.te
semodule_package -m mypolicy.mod -o mypolicy.pp [-f mypolicy.fc]
```

Install & load module:

```bash
semodule -i mypolicy.pp
```

Ensure file context matches our policy:

```bash
matchpathcon /opt/test
```

Restore context on file:

```bash
restorecon /opt/test
```

List current active modules:

```bash
semodule -l
```
