# How to use

1. Copy the `values.sample.sh` file into `values.sh`, and `openssl.sample.cnf` file into `openssl.cnf`
1. Edit the copied file to your values.
1. Generate the authority with `./gen-ca.sh`. In case you have already one, go to the next section.
1. Copy the `mygen.sample.sh` file into `mygen.sh`, edit it.
1. Run `./mygen.sh`.
1. Wait, see, enjoy!

# Import an authority

Each generated certificate is in the PEM format and in two files :

 * One for the key, named "foo.ca.key"
 * Another for the certificate, named "foo.ca.crt"

Then, you know what you have to do :)

# SSL Client authentication

Use the `gen_ident_certs`, as described in sample to generate PKCS12 authentication certificates.

If you want to protect your `p12` with a randomly generated password:

```bash
export persons="PersonName:protect
PersonName2:protect
```

## Apache2 server configuration

```
SSLEngine               On
SSLCertificateFile      /etc/ssl/www-localhost.crt
SSLCertificateKeyFile   /etc/ssl/www-localhost.key
SSLCACertificateFile    /etc/ssl/myca.ca.crt
SSLVerifyClient         require
```

## Nginx

```
ssl                     on;
ssl_certificate         /etc/ssl/www-localhost.crt;
ssl_certificate_key     /etc/ssl/www-localhost.key;
ssl_client_certificate  /etc/ssl/myca.ca.crt;
ssl_verify_client       on;
```

# Override settings with shell environment

Just use the shell: exporting variables used by the "values.sh" script will just make them the default for the rest of your shell's life.
