#!/bin/bash

make start
screen -S btc-testnet-blockcloser -d -m ./closeblock.sh