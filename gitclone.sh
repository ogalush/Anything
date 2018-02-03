#!/bin/bash

set -x
for i in 'Anything' 'cookbook' 'Pike-InstallConfigs'; do
 rm -rfv $i
 git clone https://github.com/ogalush/${i}.git
done
set +x
