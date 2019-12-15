#!/usr/bin/env sh
find ~ -type f -exec chmod 644 {} \;
find ~ -type d -exec chmod 751 {} \;
