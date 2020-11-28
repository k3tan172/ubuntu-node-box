#!/bin/bash

workon blocksat-api
cd /home/ketan/satellite/api/examples
./api_data_reader -i lo --plaintext
