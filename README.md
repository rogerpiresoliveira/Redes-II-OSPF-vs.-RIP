# Comparação de Protocolos de Roteamento: OSPF vs RIP

Este projeto tem como objetivo comparar os protocolos de roteamento **OSPF** e **RIP** em um ambiente de rede virtualizado utilizando **Docker** e **FRRouting (FRR)**. A comparação é baseada no **tempo de convergência**, ou seja, quanto tempo leva para restabelecer a conectividade após uma mudança de topologia.

## 📁 Estrutura do Projeto

```
├── custom-ubuntu/
│   └── Dockerfile
├── OSPF/
│   ├── docker-compose.yaml
│   ├── daemons
│   ├── lost-connection.sh
│   ├── new-connection.sh
│   └── R1/ ... R5/
│       └── frrX.conf
├── RIP/
│   ├── docker-compose.yaml
│   ├── daemons
│   ├── lost-connection.sh
│   ├── new-connection.sh
│   └── R1/ ... R5/
│       └── frrX.conf
├── ping-test.sh
```

## 🎯 Objetivo

- Criar uma imagem Ubuntu personalizada com FRRouting instalado.
- Montar duas topologias idênticas, uma com OSPF e outra com RIP.
- Verificar o **tempo de convergência** dos protocolos após a **falha de um link** e a **inserção de um novo**.
- Observar, via script, o tempo necessário para a máquina `M1` voltar a pingar `M2` após a mudança de topologia.

## ⚙️ Pré-requisitos

- Docker
- Docker Compose
- Permissões de execução para os scripts:

```bash
chmod +x *.sh
```

## 🚀 Passo a Passo

### 1. Construir a imagem personalizada

```bash
cd custom-ubuntu
docker build -t custom-ubuntu .
```

### 2. Rodar a topologia (OSPF ou RIP)

```bash
cd OSPF     # ou cd RIP
docker-compose up --build
```

> O container `M1` executa automaticamente o ping para `M2`. O tempo de retomada da resposta mostra o tempo de convergência do protocolo.

### 3. Simular falha de link

```bash
./lost-connection.sh
```

### 4. Simular novo caminho

```bash
./new-connection.sh
```

## 🧹 Parar e limpar os containers

```bash
docker-compose down
```

## 🔍 Comandos Úteis

### Acessar um container

```bash
docker exec -it R1 bash
```

### Ver a tabela de roteamento no FRRouting

```bash
vtysh
show ip route
```

### Ver IPs e interfaces

```bash
ip a
```

### Testar conectividade manual

```bash
ping <endereço IP de destino>
```

## 🖼️ Topologia (Resumo)

- 5 roteadores interconectados (R1 a R5)
- 2 máquinas (M1 e M2) nas extremidades da rede
- Configurações de roteamento feitas via arquivos `frrX.conf`
- Docker Compose define as interconexões e redes

## 📊 Objetivo Final

Comparar OSPF e RIP em termos de:

- Tempo de convergência após falhas
- Robustez e estabilidade das rotas
- Simplicidade de configuração e resposta em redes dinâmicas
