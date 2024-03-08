#!/bin/bash
cd /root/prototype/vuln; node app.js &
/usr/sbin/sshd -p 2222 -D 
