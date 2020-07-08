#!/bin/bash
v=$1
cfgFolder="configs"
flag=false

# Check if each source file exist.
if [ ! -f "${cfgFolder}/config${v}.env" ]; then 
    echo "${cfgFolder}/config${v}.env not exist"
    flag=true
fi
if [ ! -f "${cfgFolder}/docker-compose${v}.yml" ]; then 
    echo "${cfgFolder}/docker-compose${v}.yml not exist"
    flag=true
fi
if [ ! -f "${cfgFolder}/training_params${v}.yaml" ]; then 
    echo "${cfgFolder}/training_params${v}.yaml not exist"
    flag=true
fi
if [ flag == "true" ]; then
    echo "Do nothing and exit."
    exit 1
fi

# copy config files
echo "cp ${cfgFolder}/config${v}.env config.env"
cp ${cfgFolder}/config${v}.env config.env
echo "cp ${cfgFolder}/docker-compose${v}.yml docker-compose.yml"
cp ${cfgFolder}/docker-compose${v}.yml docker-compose.yml
echo "cp ${cfgFolder}/training_params${v}.yaml data/minio/bucket/custom_files/training_params.yaml"
cp ${cfgFolder}/training_params${v}.yaml data/minio/bucket/custom_files/training_params.yaml