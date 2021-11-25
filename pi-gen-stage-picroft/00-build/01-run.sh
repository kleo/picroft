#!/bin/bash -e

set -exu

mkdir -pv ${ROOTFS_DIR}/etc/mycroft
curl -L -o ${ROOTFS_DIR}/etc/mycroft/mycroft.conf https://raw.githubusercontent.com/MycroftAI/enclosure-picroft/buster/etc/mycroft/mycroft.conf
install -d -m 0755 "${ROOTFS_DIR}/etc/mycroft"
install -m 0644 "files/etc/mycroft/mycroft.conf" "${ROOTFS_DIR}/etc/mycroft/mycroft.conf"
install -v -m 0644 files/etc/systemd/system/getty@tty1.service.d/autologin.conf "${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/autologin.conf"

install -m 0644 -o "${FIRST_USER_NAME}" "files/home/pi/.bashrc" "${ROOTFS_DIR}/home/pi/.bashrc"
install -m 0644 -o "${FIRST_USER_NAME}" "files/home/pi/AIY-asound.conf" "${ROOTFS_DIR}/home/pi/AIY-asound.conf"
install -m 0644 -o "${FIRST_USER_NAME}" "files/home/pi/version" "${ROOTFS_DIR}/home/pi/version"
install -v -d -m 0755 "${ROOTFS_DIR}/etc/mycroft"
install -v -m 0644 files/etc/mycroft/mycroft.conf "${ROOTFS_DIR}/etc/mycroft/mycroft.conf"

install -v -m 0644 -o "${FIRST_USER_NAME}" files/home/pi/.bashrc "${ROOTFS_DIR}/home/pi/.bashrc"
install -v -m 0644 -o "${FIRST_USER_NAME}" files/home/pi/AIY-asound.conf "${ROOTFS_DIR}/home/pi/AIY-asound.conf"
install -v -m 0644 -o "${FIRST_USER_NAME}" files/home/pi/version "${ROOTFS_DIR}/home/pi/version"

install -v -m 0755 -o "${FIRST_USER_NAME}" files/home/pi/audio_setup.sh "${ROOTFS_DIR}/home/pi/audio_setup.sh"
install -v -m 0755 -o "${FIRST_USER_NAME}" files/home/pi/auto_run.sh "${ROOTFS_DIR}/home/pi/auto_run.sh"
install -v -m 0755 -o "${FIRST_USER_NAME}" files/home/pi/custom_setup.sh "${ROOTFS_DIR}/home/pi/custom_setup.sh"
install -v -m 0755 -o "${FIRST_USER_NAME}" files/home/pi/update.sh "${ROOTFS_DIR}/home/pi/update.sh"

install -v -d -m 0755 -o "${FIRST_USER_NAME}" "${ROOTFS_DIR}/home/pi/bin"
install -v -m 0755 -o "${FIRST_USER_NAME}" files/home/pi/bin/mycroft-setup-wizard "${ROOTFS_DIR}/home/pi/bin/mycroft-setup-wizard"
install -v -m 0755 -o "${FIRST_USER_NAME}" files/home/pi/bin/mycroft-wipe "${ROOTFS_DIR}/home/pi/bin/mycroft-wipe"

on_chroot << EOF
sudo -u pi -E git clone --verbose --progress --depth 1 --branch ${BRANCH} https://github.com/MycroftAI/mycroft-core /home/pi/mycroft-core
sudo -u pi -E bash /home/pi/mycroft-core/dev_setup.sh
EOF
