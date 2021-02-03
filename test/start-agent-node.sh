#!/bin/bash

while getopts ":m:" arg; do
    case $arg in
        m) MainIpAddress=$OPTARG;;
    esac
done

usage() {
    script_name=`basename $0`
    echo "Please use ./$script_name -m ip-address"
}

if [ -z "$MainIpAddress" ]; then
    usage
    exit 1
fi

sudo sysctl -w fs.file-max=500000

sudo apt-get update
sudo apt-get upgrade --yes
sudo apt-get install python3-pip --yes

pip3 install locust
pip3 install Faker

~/.local/bin/locust -f locustfile.py --worker --master-host=$MainIpAddress &
