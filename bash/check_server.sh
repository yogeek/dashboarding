#!/usr/bin/env bash

APP_URL="http://nginx"

BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

while true; do 
    sleep 2
    v=$(curl -s -H 'Cache-Control: no-cache' ${APP_URL} | grep "Version" | sed -r 's/<h1.*>(.+)<\/h1>/\1/') 
    [[ $(echo $v | grep Blue) ]] && COLOR=${BLUE} || COLOR=${GREEN}
    echo -e "$(date "+%H-%M-%S") : ${COLOR} $v ${NC} : OK"
done