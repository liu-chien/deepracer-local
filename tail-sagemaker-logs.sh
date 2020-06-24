#!/bin/bash

if [ $1 != "" ]; then
  SAGEMAKER_ID=$1
  echo "SAGEMAKER_ID=$1"
fi

while [ -z $SAGEMAKER_ID ]
do
  echo "Waiting for sagemaker to start..."
  SAGEMAKER_ID=$(docker ps | grep sagemaker | awk '{ print $1}')
  sleep 1
done

docker logs -f $SAGEMAKER_ID
