#!/bin/bash

sudo sysctl -w fs.pipe-max-size=33554432
/usr/local/bin/blocksat-cli sdr --gui -g 20 --derotate -100 -d
