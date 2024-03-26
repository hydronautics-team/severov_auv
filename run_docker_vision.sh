docker run --rm -it --gpus all \
    -v $HOME/severov_auv:/severov_auv \
    --ipc=host \
    --device=/dev/video0 \
    --net=host \
    hydronautics/severov_auv:vision \
    bash
