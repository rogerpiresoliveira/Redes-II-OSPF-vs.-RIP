#!/bin/bash

# Verifica se os containers estão rodando
if ! docker inspect -f '{{.State.Running}}' R1 &>/dev/null || ! docker inspect -f '{{.State.Running}}' R5 &>/dev/null; then
    echo "Erro: Os containers R1 e R5 precisam estar em execução."
    exit 1
fi

# Criação do veth pair
sudo ip link add veth-r1 type veth peer name veth-r5
sudo ip link set veth-r1 up
sudo ip link set veth-r5 up

# Conectando as interfaces aos containers
PID_R1=$(docker inspect -f '{{.State.Pid}}' R1)
PID_R5=$(docker inspect -f '{{.State.Pid}}' R5)

sudo ip link set veth-r1 netns $PID_R1
sudo ip link set veth-r5 netns $PID_R5

# Configurando as interfaces dentro dos containers
docker exec -it R1 bash -c "ip link set veth-r1 name r1-r5 && \
                          ip addr add 10.10.8.1/24 dev r1-r5 && \
                          ip link set r1-r5 up"

docker exec -it R5 bash -c "ip link set veth-r5 name r5-r1 && \
                          ip addr add 10.10.8.2/24 dev r5-r1 && \
                          ip link set r5-r1 up"

echo "Conexão entre R1 e R5 estabelecida com sucesso. Verifique as configurações do OSPF."

