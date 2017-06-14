#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"                                                                                                                                                                                
source $DIR/env.sh

dockerName=`docker ps | grep "symphony-notebook" | awk  '{print $1}'`
tokenStr=`docker exec -ti $dockerName jupyter notebook list`
echo $tokenStr
echo $tokenStr| awk -F= '{print$2}'| awk '{print $1}'
