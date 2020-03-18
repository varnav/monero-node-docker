#!/bin/bash
set -e

exec ./monerod --non-interactive --restricted-rpc --rpc-bind-ip=0.0.0.0 --confirm-external-bind "$@"