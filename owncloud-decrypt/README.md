# How to decrypt with decrypt.php

**UNMAINTAINED PROJECT**

If you want some help about decrypting your files, you may try this project but success is, as you guess, not guaranteed at all.

If you think you can be of any help, fork this project.

## Requirements

 * PHP >= 5.5 built with OpenSSL
 * User's password :)

## Run it

```bash
php decrypt.php -u <user> -p <user_password> -f <file> [-D /path/to/owncloud/data] [-d] [-m 2|3 -i insanceid -I secret]
```

Where `<file>` is the full path from the root of ownCloud data. Example:

```bash
php decrypt.php -u admin -p admin -f test_owncloud.txt
```

Decrypted files are stored into the `decrypted/<user>/` directory.

## Infos

If your user is a uniq ID (LDAP and so...), like `aefd004-441ffe....`, use this uniq ID.

The values of `instanceid` and `secret` are found in `config/config.php`.

# Compatibility

 * `8.1`: no specific options.
 * `8.2`: use `-m 2 -i instanceid -I secret`.
 * `9.0`: use `-m 3 -i instanceid -I secret`.
 * `9.1`: use `-m 3 -i instanceid -I secret`.

If you sucessfuly got it working for another version, please tell me in an issue :)

## Tests

Here is how I add tests:

 * Install OC **from scratch**.
 * Create the `admin` user with password `admin`.
 * Enable Encryption App and activate server-side encryption.
 * Logout-login as admin, then create a `test.txt` file with content `SUCCESS`, no new line at the end.
 * Logout-login as admin again, verify `test.txt`.
 * Upload the `data` and `config` folder into `test/data/oc<version>`.
 * Remove useless files such as logs, database, trashbin, cache.

# If it doesn't works

The best way to get it working, if you can't to modify the code, is to let me get the full environment where it happen. If this isn't doable, let me a procedure so I can build the same env as you have (OS, ownCloud version, steps to create the file etc...).

As i'm not actively following ownCloud's evolution, please do not expect me to solve your problem, even if i try :)

Thanks

# Backups

Even if you have encrypted files on disk, don't forget to backup `config/config.php` since it contains mandatory data for file decryption.

When using this tool, you should not need to do any backup of any files since it doesn't write into existing files.

# How it works

You will need the user's password. Also, different OC versions have different encryption ways so, better read at the code. It's not very hard.

# Code quality

Horrible.
