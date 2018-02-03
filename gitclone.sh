#!/bin/bash

set -x
for i in 'Anything' 'cookbook' 'Pike-InstallConfigs'; do
 rm -rfv $i
 git clone https://github.com/ogalush/${i}.git
done
find */.git -name config -exec sed -i 's/github.com/ogalush@github.com/' {} \;
set +x
