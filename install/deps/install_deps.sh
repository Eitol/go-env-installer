#!/usr/bin/env bash

####### CONFIG   #######################
SRC_INSTALL_DIR=${GOPATH}/src
########################################

validate_instalation(){
    # Check gopath
    if [[ -z "${GOPATH}" ]]; then
        echo "ERROR: Set GOPATH to continue the deps installation" 1>&2
        exit 1
    fi
}

install_grpc_ecosystem_deps(){
    go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
    go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
    go get -u github.com/grpc-ecosystem/grpc-gateway.git
    go get -u github.com/golang/protobuf/protoc-gen-go

    # for nullable fields: https://github.com/gogo/protobuf/issues/309
    go get github.com/gogo/protobuf/protoc-gen-gofast
}

install_kafka_deps(){
  ## Install librdkafka
  _PWD=`pwd`
  mkdir /tmp/librdkafka
  cd /tmp/librdkafka
  git clone https://github.com/edenhill/librdkafka.git
  cd librdkafka
  ./configure --prefix /usr
  make -j6
  echo "#########\nPLEASE TYPE YOUR SUDO PASSWORD\n#########"
  sudo make install
  cd ${_PWD}
  # Install the go client
  go get -u github.com/confluentinc/confluent-kafka-go/kafka
}

bash ./install_go.sh
install_grpc_ecosystem_deps
install_kafka_deps

