docker run --rm -it --gpus all \
    -v $HOME/severov_auv:/severov_auv \
    --device=/dev/ttyTHS0 \
    --ipc=host \
    --net=host \
    hydronautics/severov_auv:control \
    bash
