docker-monero        [![Docker Stars](https://img.shields.io/docker/stars/raboo/monero.svg)](https://hub.docker.com/r/raboo/monero/)        [![Docker Pulls](https://img.shields.io/docker/pulls/raboo/monero.svg)](https://hub.docker.com/r/raboo/monero/)
=============

*[monero](http://monero.org) containers based on alpine-glibc*


# Pulling
    docker pull raboo/monero

# Initial blockchain sync/bootstrap
    wget https://downloads.getmonero.org/blockchain.raw
    mkdir -p $HOME/.bitmonero/export
    mv blockchain.raw $HOME/.bitmonero/export/
    docker run -it --rm -v $HOME/.bitmonero:/root/.bitmonero \
        raboo/monero monero-blockchain-import --db-salvage

# Running the Daemon
    docker run -dit --name monero \
        -v $HOME/.bitmonero:/root/.bitmonero \
        -p 18080:18080 -p 18081:18081 \
        raboo/monero

# Checking the container status
    docker logs monero

    curl -X POST http://localhost:18081/json_rpc \
        -d '{"jsonrpc":"2.0","id":"test","method":"get_info"}' \
        -H "Content-Type: application/json" \
        -H "Accept:application/json"

# Using the wallet

## Docker exec
    docker exec -it monero monero-wallet-cli --wallet-file=wallet


## Isolated container
    docker run --rm -it --link monero \
        -v $HOME/.bitmonero:/root/.bitmonero \
        raboo/monero monero-wallet-cli \
            --wallet-file=wallet \
            --daemon-address="$MONERO_PORT_18081_TCP_ADDR:$MONERO_PORT_18081_TCP_PORT"


# Running Just the Wallet
    docker run --rm -it \
        -v $HOME/.bitmonero:/root/.bitmonero \
        raboo/monero monero-wallet-cli \
            --wallet-file=wallet
