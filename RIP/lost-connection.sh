#!/bin/bash

# Desconectar os containers R2 e R5 da rede ripcopy_R2_R5
docker network disconnect rip_R2_R5 R2
docker network disconnect rip_R2_R5 R5

# Mensagem de sucesso
echo "Containers R2 e R5 desconectados da rede R2_R5."
