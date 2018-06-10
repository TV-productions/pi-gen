#!/bin/bash -e

install -d ${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d
install -m 644 files/noclear.conf ${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/noclear.conf
install -m 744 files/policy-rc.d ${ROOTFS_DIR}/usr/sbin/policy-rc.d #TODO: Necessary in systemd?
install -v -m 644 files/fstab ${ROOTFS_DIR}/etc/fstab

on_chroot << EOF
if ! id -u ${DEFAULT_USER} >/dev/null 2>&1; then
	adduser --disabled-password --gecos "" ${DEFAULT_USER}
fi
echo "${DEFAULT_USER}:${DEFAULT_PASS}" | chpasswd
echo "root:root" | chpasswd
EOF
