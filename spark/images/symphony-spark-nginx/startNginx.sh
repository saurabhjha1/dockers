#!/bin/bash
nginx -s reload
chmod +x /bin/sparkProxy.py
nohup python /bin/sparkProxy.py sparkMaster:8080 9999 &
