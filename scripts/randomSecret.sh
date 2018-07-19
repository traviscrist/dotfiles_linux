#!/bin/bash
# date +%s | shasum -a 256 | base64 | head -c 32 ; echo
openssl rand 32 | base64 \
  | sed -e 's/\+/-/g' -e 's/\//_/g' -e 's/=//g'