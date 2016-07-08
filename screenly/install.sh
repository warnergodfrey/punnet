#!/bin/bash -e

BRANCH="master"
EXTRA_ARGS="--skip-tags enable-ssl"

# /boot doesn't exist under qemu
# The BerryBoot marker tells screenly to ignore steps that depend on /boot
touch /etc/berryboot

set -x
mkdir -p /etc/ansible
echo -e "[local]\nlocalhost ansible_connection=local" | tee /etc/ansible/hosts > /dev/null

if [ ! -f /etc/locale.gen ]; then
  # No locales found. Creating locales with default UK/US setup.
  echo -e "en_GB.UTF-8 UTF-8\nen_US.UTF-8 UTF-8" | tee /etc/locale.gen > /dev/null
  locale-gen
fi


sed -i 's/apt.screenlyapp.com/archive.raspbian.org/g' /etc/apt/sources.list
apt-get update
apt-get purge -y python-setuptools python-pip python-pyasn1
apt-get install -y python-dev git-core libffi-dev libssl-dev
curl -s https://bootstrap.pypa.io/get-pip.py | python
pip install ansible==2.1.0.0

ansible localhost -m git -a "repo=${1:-http://github.com/wireload/screenly-ose.git} dest=/home/pi/screenly version=$BRANCH"
cd /home/pi/screenly/ansible

ansible-playbook site.yml $EXTRA_ARGS

apt-get autoclean
apt-get clean
find /usr/share/doc -depth -type f ! -name copyright -delete
find /usr/share/doc -empty -delete
rm -rf /usr/share/man /usr/share/groff /usr/share/info /usr/share/lintian /usr/share/linda /var/cache/man
find /usr/share/locale -type f ! -name 'en' ! -name 'de*' ! -name 'es*' ! -name 'ja*' ! -name 'fr*' ! -name 'zh*' -delete
find /usr/share/locale -mindepth 1 -maxdepth 1 ! -name 'en*' ! -name 'de*' ! -name 'es*' ! -name 'ja*' ! -name 'fr*' ! -name 'zh*' -exec rm -r {} \;

cd ~/screenly && git rev-parse HEAD > ~/.screenly/latest_screenly_sha

set +x
echo "Installation completed."
fi
