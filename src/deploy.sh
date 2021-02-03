#!/bin/bash

while getopts ":f:" arg; do
    case $arg in
        f) FunctionAppName=$OPTARG;;
    esac
done

usage() {
    script_name=`basename $0`
    echo "Please use ./$script_name -f function-app-name"
}

if [ -z "$FunctionAppName" ]; then
    usage
    exit 1
fi

dotnet restore

dotnet build

pushd ScaleTestEndpoint

func azure functionapp publish $FunctionAppName

popd
