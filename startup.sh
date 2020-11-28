#!/bin/bash

echo Password1 | sudo -S sysctl -w fs.pipe-max-size=33554432
/usr/bin/blocksat-cli sdr --gui -g 20 --derotate -100 -d
