#! /bin/bash

wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz

rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz

echo  "export PATH=$PATH:/usr/local/go/bin"
