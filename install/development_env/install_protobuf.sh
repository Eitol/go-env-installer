#!/usr/bin/env bash

# run like:
# sudo -S bash ./install_protobuf.sh


#-------- Config ---------
SO=linux-x86_64   # linux-x86_64 | linux-x86_32 | windows | osx
PROTOBUF_REPO="protocolbuffers/protobuf"
PROTOBUF_USER=`whoami`


#-------- Functions ---------

get_latest_github_repo_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/' |                                  # Pluck JSON value
    tr -d "v"                                                       # Remove v char
}

check_if_file_is_void() {
    SIZE=$(du -sb $1 | awk '{ print $1 }')
    if [[ ${SIZE} -lt 1024 ]] ; then
        echo true;
    else
        echo false;
    fi
}

install_protobuf() {
    PROTOBUF_VERSION=`get_latest_github_repo_release ${PROTOBUF_REPO}`
    FILE=protoc-${PROTOBUF_VERSION}-${SO}.zip
    URL=https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/${FILE}
    curl -OL  ${URL}

    # Check download
    IS_VOID_FILE=`check_if_file_is_void ${FILE}`
    if [[ ${IS_VOID_FILE} == true ]]; then
        echo "Problem downloading protobuf"
        exit 1
    else
        echo "protobuf is downloaded OK!"
    fi
    echo "Installing..."
    unzip ${FILE} -d protoc3
    sudo mv -f protoc3/bin/* /usr/local/bin/
    sudo mv -f protoc3/include/* /usr/local/include/
    sudo chown ${PROTOBUF_USER} /usr/local/bin/protoc
    sudo chown -R ${PROTOBUF_USER} /usr/local/include/google
    echo "Done!"
}


#-------- Routine ---------

install_protobuf
