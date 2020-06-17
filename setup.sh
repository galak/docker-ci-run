#!/bin/bash -e

apt-get clean
apt-get update

# software-properties for add-apt-repository
# locales for LANG support
# sudo to make life easier when running as build user
# vim.tiny so we have an editor
apt-get install -y --no-install-recommends software-properties-common \
	locales sudo vim.tiny

# The package sets are based on Yocto & crosstool-ng docs/references:
#
# Yocto:
# https://www.yoctoproject.org/docs/2.3.4/ref-manual/ref-manual.html#ubuntu-packages
#
# crosstool-ng:
# https://github.com/crosstool-ng/crosstool-ng/blob/master/testing/docker/ubuntu18.04/Dockerfile

apt-get install -y --no-install-recommends python3-pip libusb-1.0 wget gcc python3-dev xz-utils file

# Grab a new git
add-apt-repository ppa:git-core/ppa -y
apt-get update
apt-get install git -y

wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.11.3/zephyr-sdk-x86_64-hosttools-standalone-0.9.sh
chmod a+x ./zephyr-sdk-x86_64-hosttools-standalone-0.9.sh
./zephyr-sdk-x86_64-hosttools-standalone-0.9.sh -d /opt/zephyr-sdk -y
rm zephyr-sdk-x86_64-hosttools-standalone-0.9.sh

wget https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/master/scripts/requirements-base.txt
pip3 install setuptools
pip3 install -r requirements-base.txt
rm requirements-base.txt

wget https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/master/scripts/requirements-build-test.txt
pip3 install -r requirements-build-test.txt
rm requirements-build-test.txt

wget https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/master/scripts/requirements-run-test.txt
pip3 install -r requirements-run-test.txt
rm requirements-run-test.txt

ln -s /opt/zephyr-sdk/sysroots/x86_64-pokysdk-linux/usr/bin/openocd /usr/local/bin/
