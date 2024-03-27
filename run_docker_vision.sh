docker run --rm -it --gpus all \
    --ipc=host \
    --device=/dev/video0 \
    --net=host \
    hydronautics/severov_auv:vision \
    bash
