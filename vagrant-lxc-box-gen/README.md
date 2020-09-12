# Build Vagrant LXC Boxes

Use the vagrant `vagrant-lxc` plugin:

https://github.com/fgrehm/vagrant-lxc

```
vagrant plugin install vagrant-lxc
```

## gen-vagrant-box.sh

Bash script with some options:

 * `-n`: container name.
 * `-p`: some postscript files to run.
 * `-N` optional: box name.
 * `-P` optional: change the `lxc.lxcpath` for the different `lxc-` commands.

Example:

```
$ ./gen-vagrant-box.sh -n pure-debian8 \
    -p debian \
    -p mypostscript \
    -p myotherpostscript \
    -P /mnt/custom_lxc_path \
    -N custom-debian8-box
```

### postscripts

Postscripts files are copied and launched into the container via the `lxc-attach` command.

The `default` postscript is needed to setup the `vagrant` user and the Vagrant insecure ssh key.

The `sudo` installation is left to you. Either you install it from the container you start from, either you do it from postscripts.

## Vagrantfile

Check the different options you can / must set in you `Vagrantfile` for the `vagrant-lxc` plugin.

You may want to change the `backingstore` option in you `Vagrantfile` to handle correct setup:

https://github.com/fgrehm/vagrant-lxc#backingstore-options

## Requirements

 * `lxc >= 1.0`
 * `rsync`
 * The usual network interfaces, `iptables`, `DHCP` and `DNS` things. See further.
 * For some guests, a recent kernel might be mandatory. For example it's hard to boot a Debian Jessie (8) guest from a CentOS 7 (3.10.x kernel) host.
 * Container must already start and stop correctly.
 * Any container-specific configuration must be enclosed by `# NOT GENERIC #` and `# /NOT GENERIC #` tags.

## dnsmasq and network

`systemd-networkd` bridge interface:

```
$ cat /etc/systemd/network/lxcbr0.netdev 
[NetDev]
Name=lxcbr0
Kind=bridge

$ cat /etc/systemd/network/lxcbr0.network 
[Match]
Name=lxcbr0

[Network]
Address=10.253.1.254/24
IPForward=yes
IPMasquerade=yes
ConfigureWithoutCarrier=yes
```

`/etc/dnsmasq.conf`:

```
local=/amidala.local/
domain=amidala.local
bogus-priv

interface=lxcbr0
listen-address=10.253.1.254
dhcp-range=10.253.1.128,10.253.1.253,255.255.255.0
dhcp-option=42,10.253.0.254 # NTP server
```

`iptables` rules:

```
iptables -t mangle -A POSTROUTING -o lxcbr0 -p udp -m udp --dport 67:68 -j CHECKSUM --checksum-fill
iptables -t nat -A POSTROUTING -s 10.253.0.0/24 ! -d 10.253.0.0/24 -j MASQUERADE
```
