# centreon-cmdexpand

Expand Centreon service commands with (almost) all values - Python

# Install

Requires `sqlalchemy` and `python-mysql`.

# Usage

```
python2 centcmd.py --dburi 'mysql://centreon_ro:centreon@localhost:3306/centreon' --host='YourHost' --service='YourService'
```

# Supports

 * `$_HOST...$` macros, from templates & host
 * `$_SERVICE...$` macros, from template & service
 * `$ARG...$` from template & service
 * `$HOSTADDRESS$`
 * `$_HOSTSNMPCOMMUNITY$`
 * `$_HOSTSNMPVERSION$`
 * `$USER...$` and other resources
