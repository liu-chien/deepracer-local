# AWS DeepRacer Console
from_aws_cloudwatch = False
stream_name = 'training-25b466e7a1bb' ## CHANGE This to your simulation application ID
fname = 'logs/deepracer-%s.log' %stream_name  # The log will be downloaded into the specified path

# if you are using deepracer-local-training through docker and it is still running
# then you can enable this variable to download the training logs automatically
local_training_current_running = True
sagemaker_network_name = 'sagemaker-local-1'

if local_training_current_running:
    # get docker process id
    import os
    os.environ['SAGEMAKER_NETWORK_NAME'] = sagemaker_network_name
    outputs = !docker ps -a -f network=$SAGEMAKER_NETWORK_NAME | awk '/robomaker/ { print $1 }'
    print(outputs)
    assert len(outputs) > 0
    process_id = outputs[0]
    
    print('Download logs from running docker process: {}'.format(process_id))
    
    stream_name = 'training-{}'.format(process_id)
    fname = 'logs/deepracer-{}.log'.format(stream_name)
    
    # dump training logs from process_id
    p = !docker logs {process_id} 2> logs/deepracer-training-{process_id}.log
    print('Training logs are saved to: {}'.format(fname))

if from_aws_cloudwatch:
    cw.download_log(fname, stream_prefix=stream_name)  # add force=True if you downloaded the file before but want to repeat