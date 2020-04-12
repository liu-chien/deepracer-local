#!/usr/bin/env bash


source config.env


echo "Stop project: ${PROJECT_NAME}"

export ROBOMAKER_COMMAND=""
docker-compose -p ${PROJECT_NAME} -f ./docker-compose.yml down

docker stop $(docker ps -a --filter network=${SAGEMAKER_NETWORK_NAME} | awk ' /sagemaker/ { print $1 }')
docker rm $(docker ps -a --filter network=${SAGEMAKER_NETWORK_NAME}| awk ' /sagemaker/ { print $1 }')

#if [ "$ENABLE_LOCAL_DESKTOP" = true ] ; then
#    wmctrl -c kvs_stream
#fi

#if [ ! -z "$(which tmux)" ]
#then
#  tmux kill-session
#fi

