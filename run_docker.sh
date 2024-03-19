docker run --rm -it --gpus all\
    -v $HOME/severov_auv:/severov_auv \
    --device=/dev/ttyTHS0 \
    --device=/dev/video0 \
    --net=host \
    hydronautics/severov_auv:latest \
    bash
