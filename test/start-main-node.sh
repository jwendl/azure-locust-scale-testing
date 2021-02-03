#!/bin/bash

while getopts ":w:" arg; do
    case $arg in
        w) WebEndpoint=$OPTARG;;
    esac
done

usage() {
    script_name=`basename $0`
    echo "Please use ./$script_name -w web-endpoint"
}

if [ -z "$WebEndpoint" ]; then
    usage
    exit 1
fi

sudo sysctl -w fs.file-max=500000

sudo apt-get update
sudo apt-get upgrade --yes
sudo apt-get install python3-pip --yes

pip3 install locust
pip3 install Faker

~/.local/bin/locust -f locustfile.py --master --headless --host=$WebEndpoint -u 1000 -r 100 --run-time 3m --expect-workers 10 &
