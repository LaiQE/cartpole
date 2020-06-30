FROM tensorflow/tensorflow:1.2.0-gpu

ARG pip_source=https://pypi.tuna.tsinghua.edu.cn/simple

WORKDIR /root
# 有些容器apt update失败因为没装这个
# http://archive.ubuntu.com/ubuntu/ubuntu/pool/main/a/apt/apt-transport-https_1.2.10ubuntu1_amd64.deb
# ADD apt-transport-https_1.2.10ubuntu1_amd64.deb /root

RUN set -ex\
    && curl https://mirrors.ustc.edu.cn/repogen/conf/ubuntu-http-4-xenial > /etc/apt/sources.list \
    # && sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    # 把和nvidia有关的删除
    && rm -rf /etc/apt/sources.list.d/* \
    # && dpkg -i apt-transport-https_1.2.10ubuntu1_amd64.deb \
    && apt-get update\
    && apt-get install -y git python-tk zlib1g-dev libjpeg-dev xvfb libav-tools xorg-dev python-opengl libboost-all-dev libsdl2-dev swig\
    && pip install --no-cache-dir -i ${pip_source} numpy==1.10.4 requests==2.0 pyglet==1.2.0\
    && git clone -b v0.10.0 https://github.com/openai/gym.git\
    && cd gym\
    && pip install -e .\
    && apt-get autoremove

CMD bash