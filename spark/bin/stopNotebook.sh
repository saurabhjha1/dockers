#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"                                                                                                                                                                                
source $DIR/env.sh
docker service rm ${NOTEBOOK}
