# OpenLDAP Learning Role

## For what?

Setting up a very simple database and a root directory, but this role is mainly for learning purpose. I do not intend to extend this role with many features.

At most, I may just add some security by default, and add a monitor backend.

## For which OS?

Anything with a bourn shell and a root user should be ok.

Also, it runs with Ansible 2.x

## Wanna run?

The inventory is configured with your local machine, and you need the openldap server already installed.

Check the `defaults` variables to configure properly.

Run this as root, or modify the inventory to connect/login as `root`. You can use `sudo`.

```
ansible-playbook -i inventory -e openldap_reset=True playbook.yml -vv
```

Please notice the `-e openldap_reset=True`. By default it is set to `false` to prevent any unwanted removal.

## Wanna test?

```
$ ldapsearch -LLL -h localhost -x -w manager -D cn=manager,dc=domain -b dc=domain
dn: dc=domain
objectClass: domain
dc: domain
```

Success!

## Wanna hack?

Be free to do anything you want. This role is meant to stay as simple as possible, making anyone able to understand how to setup an OpenLDAP server from scratch with LDIF files.

If you want features, please *copy* this project elsewhere.

## Wanna understand?

Read the following man pages:

 * `slapd-config`
 * `ldapadd`
 * `ldapmodify`
 * `ldappasswd`
 * `ldapsearch`

Those pages may help you:

 * http://www.openldap.org/doc/admin24/slapdconf2.html
 * http://www.openldap.org/doc/admin24/

Good luck!
