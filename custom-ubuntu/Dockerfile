FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    iproute2 \
    iputils-ping \
    net-tools \
    tcpdump \
    vim \
    traceroute \
    iperf3 \
    && apt-get clean

CMD ["bash"]
