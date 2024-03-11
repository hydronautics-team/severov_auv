docker run --rm -it \
    -v $HOME/severov_auv:/severov_auv \
    --device=/dev/ttyTHS0 \
    --device=/dev/video0 \
    --net=host \
    severov_auv:latest \
    bash
