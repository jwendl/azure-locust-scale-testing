#!/bin/bash

while getopts ":u:p:o:l:" arg; do
    case $arg in
        u) UserName=$OPTARG;;
        p) Prefix=$OPTARG;;
        o) Postfix=$OPTARG;;
        l) Location=$OPTARG;;
    esac
done

usage() {
    script_name=`basename $0`
    echo "Please use ./$script_name -u user-name -p prefix -o postfix -l location"
}

if [ -z "$UserName" ]; then
    usage
    exit 1
fi

if [ -z "$Prefix" ]; then
    usage
    exit 1
fi

if [ -z "$Postfix" ]; then
    usage
    exit 1
fi

if [ -z "$Location" ]; then
    usage
    exit 1
fi

mainName="${Prefix}mvm${Postfix}"
agentName="${Prefix}avm${Postfix}"

ssh -o StrictHostKeyChecking=no "$UserName@$mainName.$Location.cloudapp.azure.com" "pkill -9 -f locust"

for index in {0..9}
do
    ssh -o StrictHostKeyChecking=no "$UserName@$agentName-$index.$Location.cloudapp.azure.com" "pkill -9 -f locust"
done
