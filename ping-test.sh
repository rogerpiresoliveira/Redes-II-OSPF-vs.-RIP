#!/bin/bash

# Registra o tempo inicial
start_time=$(date +%s)

# Espera até que M1 consiga pingar M2
while ! ping -c 1 10.10.7.2 > /dev/null 2>&1; do
    sleep 1
done

# Registra o tempo final
end_time=$(date +%s)

# Calcula o tempo decorrido
elapsed_time=$((end_time - start_time))

# Exibe o tempo que levou para M1 e M2 começarem a se comunicar
echo "O tempo para M1 conseguir se comunicar com M2 foi de $elapsed_time segundos."
