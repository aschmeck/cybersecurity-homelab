#!/bin/bash

# Patterns to scrub
HOSTNAMES=("hostname-redacted" "hostname-redacted")
USERNAMES=("user-redacted")
IPS=("10\\.1\\.10\\.162" "192\\.168\\.122\\.[0-9]{1,3}" "192\\.168\\.10\\.[0-9]{1,3}")
MAC_REGEX="[A-Fa-f0-9:]\{17\}"

# Replace hostnames
for name in "${HOSTNAMES[@]}"; do
    find . -type f -exec sed -i "s/$name/hostname-redacted/g" {} +
done

# Replace usernames
for user in "${USERNAMES[@]}"; do
    find . -type f -exec sed -i "s/$user/user-redacted/g" {} +
done

# Replace IP ranges
for ip in "${IPS[@]}"; do
    find . -type f -exec sed -i -E "s/$ip/ip-redacted/g" {} +
done

# Replace MAC addresses
find . -type f -exec sed -i -E "s/$MAC_REGEX/mac-redacted/g" {} +

echo "Scrub complete."
