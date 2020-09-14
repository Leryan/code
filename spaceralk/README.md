# Spaceralk

[![Build Status](https://travis-ci.org/Leryan/spaceralk.svg?branch=master)](https://travis-ci.org/Leryan/spaceralk)
[![crates.io](https://img.shields.io/crates/v/spaceralk.svg)](https://crates.io/crates/spaceralk)

Speak to Spacewalk XML-RPC API with Rust.

[Documentation](https://docs.rs/spaceralk/0.1.0/spaceralk/)

```
$ cargo run -- -U http://<spacewalk_addr:port>/ -u user -p password -m channel.listAllChannels
$ cargo run -- -U http://<spacewalk_addr:port>/ -u user -p password -m channel.software.listAllPackages -j '["channel_label"]'
```

## TODO

 * Better error handling.
