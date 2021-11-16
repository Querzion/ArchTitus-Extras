#!/bin/bash

#################################
## Begin of user-editable part ##
#################################

POOL=ethash.poolbinance.com:3333
WALLET=0x13f1f8abe7ef3bacd7fac5b3748e0cec8fe5c604.LinuxManjaro.001

#################################
##  End of user-editable part  ##
#################################

cd "$(dirname "$0")"

./lolMiner --algo ETHASH --pool $POOL --user $WALLET $@
while [ $? -eq 42 ]; do
    sleep 10s
    ./lolMiner --algo ETHASH --pool $POOL --user $WALLET $@
done
