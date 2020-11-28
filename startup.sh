#!/bin/bash

sudo echo 33554432 > /proc/sys/fs/pipe-max-size
/usr/local/bin/blocksat-cli sdr --gui -g 20 --derotate -100 -d
