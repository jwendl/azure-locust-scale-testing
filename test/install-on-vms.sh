#!/bin/bash

while getopts ":u:p:o:f:l:" arg; do
    case $arg in
        u) UserName=$OPTARG;;
        p) Prefix=$OPTARG;;
        o) Postfix=$OPTARG;;
        f) FunctionAppName=$OPTARG;;
        l) Location=$OPTARG;;
    esac
done

usage() {
    script_name=`basename $0`
    echo "Please use ./$script_name -u user-name -p prefix -o postfix -f function-app-name -l location"
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

if [ -z "$FunctionAppName" ]; then
    usage
    exit 1
fi

if [ -z "$Location" ]; then
    usage
    exit 1
fi

mainName="${Prefix}mvm${Postfix}"
agentName="${Prefix}avm${Postfix}"
mainIpAddress=$(az network public-ip show --resource-group TestHarness --name "${Prefix}mvmpip${Postfix}" --query ipAddress --output tsv)

ssh-keygen -f "/home/$UserName/.ssh/known_hosts" -R "$mainName.$Location.cloudapp.azure.com"
scp -o StrictHostKeyChecking=no * "$UserName@$mainName.$Location.cloudapp.azure.com:~/"
ssh -o StrictHostKeyChecking=no "$UserName@$mainName.$Location.cloudapp.azure.com" "~/start-main-node.sh -w https://${FunctionAppName}.azurewebsites.net/" &

for index in {0..9}
do
    ssh-keygen -f "/home/$UserName/.ssh/known_hosts" -R "$agentName-$index.$Location.cloudapp.azure.com"
    scp -o StrictHostKeyChecking=no * "$UserName@$agentName-$index.$Location.cloudapp.azure.com:~/"
    ssh -o StrictHostKeyChecking=no "$UserName@$agentName-$index.$Location.cloudapp.azure.com" "~/start-agent-node.sh -m ${mainIpAddress}" &
done
