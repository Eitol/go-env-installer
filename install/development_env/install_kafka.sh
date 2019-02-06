#!/usr/bin/env bash

KAFKA_USER=kafka
KAFKA_PASSWORD=123456
INSTALL_DIR=/home/kafka/kafka
KAFKA_FILE=kafka_2.12-2.1.0.tgz
KAFKA_URL=http://www-eu.apache.org/dist/kafka/2.1.0/${KAFKA_FILE}

sudo cp ../scripts/systemd/third_party/kafka.service /etc/systemd/system/kafka.service
sudo cp ../scripts/systemd/systemd/third_party/zookeeper.service /etc/systemd/system/zookeeper.service
sudo useradd ${KAFKA_USER} -m


echo -e "${KAFKA_PASSWORD}\n${KAFKA_PASSWORD}" | sudo passwd ${KAFKA_USER}
sudo adduser kafka sudo
sudo mkdir -p ${INSTALL_DIR}
cd ${INSTALL_DIR}
if [[ -f ${INSTALL_DIR} ]]; then
    echo the file exists
else
    sudo wget  ${KAFKA_URL} -P ${INSTALL_DIR}
fi
sudo tar -xvzf ./${KAFKA_FILE} --strip 1
sudo chown -hR kafka /home/kafka/

sudo systemctl enable kafka
sudo systemctl enable zookeeper
sudo service zookeeper start
sudo service kafka start