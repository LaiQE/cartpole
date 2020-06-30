xhost +
docker build -t laiqe/cartpole ./
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
-v $(pwd):/root/cartpole --gpus all laiqe/cartpole bash