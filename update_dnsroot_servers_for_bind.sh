#!/bin/bash

# Ref: https://www.cyberciti.biz/faq/unix-linux-update-root-hints-data-file/
set -x
wget --user=ftp --password=ftp ftp://ftp.rs.internic.net/domain/db.cache -O ~/db.root
chmod -v 644 ~/db.root

sudo cp -v ~/db.root /etc/bind/db.root
sudo rndc reload

set +x
