#!/bin/bash
 
if [ $ALL_PROXY == "" ];then
  echo "export ALL_RPOXY=http://127.0.0.1:7890" > /etc/profile
  source /et/profile
fi
