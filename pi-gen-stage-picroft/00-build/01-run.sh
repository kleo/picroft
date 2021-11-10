#!/bin/bash -e

set -x

mkdir -pv ${ROOTFS_DIR}/etc/mycroft
curl -L -o ${ROOTFS_DIR}/etc/mycroft/mycroft.conf https://raw.githubusercontent.com/MycroftAI/enclosure-picroft/buster/etc/mycroft/mycroft.conf

on_chroot << EOF
sudo -E -u pi -c 'git clone --verbose --progress --depth 1 --branch ${{ env.BRANCH }} https://github.com/MycroftAI/mycroft-core /home/pi/mycroft-core'
sudo -E -u pi -c 'bash /home/pi/mycroft-core/dev_setup.sh'
EOF
