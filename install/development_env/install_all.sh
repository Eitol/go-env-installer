#!/usr/bin/env bash
DIR=${PWD}/scripts/install
bash ${DIR}/deps/install_deps.sh
bash ${DIR}/develpment_dev/install_deps.sh
bash ${DIR}/develpment_dev/install_protobuf.sh
bash ${DIR}/develpment_dev/install_kafka.sh
bash ${DIR}/develpment_dev/install_mozilla_rr.sh
bash ${DIR}/develpment_dev/install_omgRPC.sh