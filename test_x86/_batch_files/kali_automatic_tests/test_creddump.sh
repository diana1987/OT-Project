#!/bin/sh
a="/root/Desktop/_OT/_reg_Win_per_version/"
for i in $a*; do
echo "*****************************************"
echo $i
r="/reg/system"
g="/reg/security"
e="/reg/sam"
sys=$i$r
sec=$i$g
sam=$i$e
echo "DUMPING Cached DATA"
echo `./cachedump.py $sys $sec true`
sleep 3 
echo "                                         "
echo "DUMPING LSA data"
echo `./lsadump.py $sys $sec true`
sleep 3
echo "Dumping SAM (local hashes) data"
echo `./pwdump.py $sys $sam true`
sleep 3
echo "*****************************************"
done
