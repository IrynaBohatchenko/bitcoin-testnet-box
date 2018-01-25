# litecoin-testnet-box docker image

# Ubuntu 14.04 LTS (Trusty Tahr)
FROM ubuntu:14.04
MAINTAINER Sean Lavine <lavis88@gmail.com>

# add litecoind
ADD https://download.litecoin.org/litecoin-0.14.2/linux/litecoin-0.14.2-x86_64-linux-gnu.tar.gz ./
RUN tar -zxvf litecoin-0.14.2-x86_64-linux-gnu.tar.gz
RUN sudo install -m 0755 -o root -g root -t /usr/local/bin ./litecoin-0.14.2/bin/*

# create a non-root user
RUN adduser --disabled-login --gecos "" tester

# run following commands from user's home directory
WORKDIR /home/tester

# copy the testnet-box files into the image
ADD . /home/tester/litecoin-testnet-box

# make tester user own the litecoin-testnet-box
RUN chown -R tester:tester /home/tester/litecoin-testnet-box

# use the tester user when running the image
USER tester

# run commands from inside the testnet-box directory
WORKDIR /home/tester/litecoin-testnet-box

# expose two rpc ports for the nodes to allow outside container access
EXPOSE 20001 20011
