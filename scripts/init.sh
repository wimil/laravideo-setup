#!/bin/bash
source ./scripts/helpers.sh
source ./scripts/prompt.sh

if [[ $OS == 'ubuntu' ]]; then
    apt update -y
    apt upgrade -y
    apt install unzip -y
else
    yum update -y
    yum install epel-release nano wget unzip -y
fi

adduser --system --no-create-home --shell /bin/false --group --disabled-login www
