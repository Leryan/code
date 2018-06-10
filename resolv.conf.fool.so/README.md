# resolv.conf.fool.so

Prevent nasty programs from taking control over `/etc/resolv.conf`.

# Build

When using `glibc`:

```
gcc -fPIC -shared -Wall -o resolv.conf.fool.so resolv.conf.fool.c -ldl -D_GNU_SOURCE
```

On systems like `FreeBSD`:

```
# clang
clang -fPIC -shared -Wall -o resolv.conf.fool.so resolv.conf.fool.c

# gcc
gcc -fPIC -shared -Wall -o resolv.conf.fool.so resolv.conf.fool.c
```

# Use

Use the `LD_PRELOAD` env variable, via `export` or temporarily on command line.

```
$ rm -f /etc/resolv.conf.rcfs-override
$ LD_PRELOAD=$(pwd)/resolv.conf.fool.so cat /etc/resolv.conf
cat: /etc/resolv.conf: Aucun fichier ou dossier de ce type

$ echo "nameserver bla.dns" > /etc/resolv.conf.rcfs-override
$ LD_PRELOAD=$(pwd)/resolv.conf.fool.so cat /etc/resolv.conf
nameserver bla.dns
```

Override the file path with `RCFS_NFILE` environment variable:

```
$ export RCFS_NFILE="/tmp/cool.resolv.conf"
$ echo "nameserver cool.bla.dns" > /tmp/cool.resolv.conf
$ LD_PRELOAD=$(pwd)/resolv.conf.fool.so cat /etc/resolv.conf
nameserver cool.bla.dns
```

# Thanks

 * This blog post: http://samanbarghi.com/blog/2014/09/05/how-to-wrap-a-system-call-libc-function-in-linux/
