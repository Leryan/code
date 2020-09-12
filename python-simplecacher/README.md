# SimpleCacher

## Description

HTTP/HTTPS, Cache proxy with SSL MITM.

I started this project with in mind `apt-cacher-ng`, but with a need to cache RPM packages… in fact, all files.

You can also cache encrypted data by proxy-ing the SSL connection with you own CA chain.

Data caching can be based only on filename, full path, with/without hostname.

This is not yet a drop-in replacement for apt-cacher-ng and certainly not a production-proof HTTP proxy.

Supported protocols:

 * HTTP
 * HTTPS

Supported HTTP methods:

 * GET
 * POST
 * HEAD
 * CONNECT

# Install


**This has been tested only on Python 3.4**


```bash
git clone https://github.com/Leryan/python-simplecacher
cd python-simplecacher
cp simplecacher.ini.sample simplecacher.ini
```

# Use

Configure allowed extensions for cache:

```ini
[cache]
allowed_ext = rpm deb tgz png svg css
```

Run it

```bash
./app.py
# you can also give another configuration file
./app.py -c /path/to/simplecacher.ini
```

Then use it in anything that only need <supported protocols> and <supported http methods>:

```bash
export http_proxy="http://<simplecacher_remote_ip>:9000"
# CentOS
yum install <anything>
# Debian
apt-get install <anything>
# cURL
curl http://linuxfr.org/
```

## SSL Man-In-The-Middle

This is bad for privacy, but cool for caching packages sent over a encrypted channel.

You will need a Certification Authority (check https://github.com/Leryan/genssl for that) and setup correctly in the `simplecacher.ini` file.
