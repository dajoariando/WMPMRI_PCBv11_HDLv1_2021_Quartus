#!/bin/bash

timenow=$(date +%m%d%H%M%Y)
#ssh root@192.168.2.133 "echo $timenow"
ssh root@192.168.137.3 "date $timenow"