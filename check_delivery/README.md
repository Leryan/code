# check_delivery.py

Check your delivery!

Protocols implemented:

 - SMTP and IMAP4
 - IRC and IRC/TLS
 - FTP and FTP/TLS
 - Flat file

Outputs available:

 - Nagios + perfdata
 - JSON

Possible scenarios:

 - Send and check from and to your "internal" servers
 - Send from your servers, check from external servers
 - Send from external servers, check from internal servers
 - Send and check from external servers \o/

# Install

Requirements:

 - `Python >= 3.2`, NO PYTHON 2

```
# From local clone
pip install -e .
pip install -e .[irc] # with IRC delivery

# Or from GitHub
pip install -e "git+https://github.com/Leryan/check_delivery.git#egg=check_delivery"
pip install -e "git+https://github.com/Leryan/check_delivery.git#egg=check_delivery[irc]"
```

# Use

```
check_delivery \
    --recv 'sendmethod://senduser:sendpassword@sendhost:port' \
    --send 'recvmethod://recvuser:recvpassword@recvhost:port' \
    --wait X
```

 - `--wait` : wait X seconds before checking the inbox.
 - There is **no** port auto-detection and I don't want to code such thing. I prefer to keep simpler code and more explicit configuration.
 - `--doc` : list all senders and receivers, with their documentation.
 - `--play` : allows you to use `scenarios`, defined in the configuration (`--conf <file>`). See `player.sample.ini`.

## Examples

```
# This example shows you how to send a mail from `usersmtp@smtpdomain.tld`
# to `userimap@imapdomain.tld`, using different servers.
check_delivery \
    --send 'smtpstarttls://usersmtp%40smtpdomain.tld:BadPassword@smtp.smtpdomain.tld:587' \
    --recv 'imapstarttls://userimap%40imapdomain.tld:OtherBadPassword@imap.domain.tld:143' \

# This example shows you how to send a mail from `usersmtp@smtpdomain.tld`
# to `userimap@imapdomain.tld`, using the same, local server.
check_delivery \
    --send 'smtp://usersmtp%40smtpdomain.tld@localhost:587' \
    --recv 'imapstarttls://userimap%40imapdomain.tld:OtherBadPassword@localhost:143/INBOX' \

# Check that a file is copied by some black magic from /dropin/sendfile to /checkout/sendfile
check_delivery --send="filerecv:///dropin/sendfile" --recv="filesend:///checkout/sendfile"
```

Or you can use an INI file containing your URLs:

```ini
[creds]
user1 = user%40domain.tld:password
user2 = user%40otherdomain.tld:password

[senders]
domain = smtpstarttls://${creds:user1}@domain.tld:port
otherdomain = smtp://${creds:user2}@otherdomain.tld:port

[receivers]
domain = imapstarttls://${creds:user1}@domain.tld:port
otherdomain = imap://${creds:user2}@otherdomain.tld:port/Unsorted

[scenarios]
domain.to.otherdomain.send = ${senders:domain}
domain.to.otherdomain.recv = ${receivers:otherdomain}

[expects]
; This section must be present, even if empty.
; See player.sample.ini to see how to use expects.
```

```
check_delivery --conf config.ini --play domain.to.otherdomain
```

Note: the INI file is read by Python's `ConfigParser`, with the `ExtendedInterpolation` string interpolation enabled.

Documentation: https://docs.python.org/3/library/configparser.html#configparser.ExtendedInterpolation

## Send methods

 - `smtp`: clear SMTP
 - `smtps`: TLS SMTP
 - `smtpstarttls`: SMTP + STARTTLS
 - `file`: flat file
 - `irc`
 - `irctls`
 - `ftp`
 - `ftps`

## Receive methods

 - `imap`: clear IMAP
 - `imaps`: TLS IMAP
 - `imapstarttls`: IMAP + STARTTLS
 - `file`: flat file
 - `irc`
 - `irctls`
 - `ftp`
 - `ftps`

## Special parameters

A parameter is sent through URL's query. Here is the list of parameters:

 - `ssl_verify`: `NONE`, `OPTIONAL` or `REQUIRED`

# Extending

Look at the `delivery_file.py` code, and the entry point `check_delivery` function in `__init__.py`.

The `launch()` function runs in this order:

 - `token_generate()`
 - `receiver.connect_early()`
 - `sender.connect()`
 - `sender.send()`: send the token
 - `sender.clean()`
 - `sender.close()`
 - `time.sleep(wait)`: wait `--wait seconds` seconds
 - `receiver.connect()`
 - `receiver.recv()`: check for the token to be received. This function **MUST** raise a `CheckDeliveryException` exception.
 - `receiver.clean()`
 - `receiver.close()`
 - `sender.close_late()`

The `connect_early()` function may be useful, for example, with an IRC delivery check, while the `close_late()` function may be useful for something asking for an ACK to work properly.

If you use those functions, you will probably want to override `connect()` and `close()` with `pass`.

Want your sender/receiver into [the core](http://www.imdb.com/title/tt0298814/)? Send a pull request.

# Tests

 - Tests done with `Python 3.5.2/ArchLinux` and `Python 3.4.3/CentOS 7`
 - Postfix 2.10.1 (plus rmilter/rspamd)
 - Dovecot 2.2.10
 - Zimbra 8.6
 - ngircd-21
 - vsftpd 3.0.3

# TODO

 - tests
 - send url parameters to each Method implementation. Could be useful, for example, to exit with an OK status even if send/recv has failed. Is case of SMTP, you'd be able to check you're not in an open relay configuration.
