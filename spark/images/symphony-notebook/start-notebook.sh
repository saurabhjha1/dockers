#!/bin/bash
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

set -e
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit
fi
cd $1
. /usr/local/bin/start.sh jupyter notebook $* &
jupyter notebook --port=8889 --ip='*'
