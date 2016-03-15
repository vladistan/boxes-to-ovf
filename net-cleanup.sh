#!/bin/bash -eux
# These were only needed for building VMware/Virtualbox extensions:
# should output one of 'redhat' 'centos' 'oraclelinux'
distro="`rpm -qf --queryformat '%{NAME}' /etc/redhat-release | cut -f 1 -d '-'`" 
rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?
# Remove development and kernel source packages
yum -y remove gcc cpp kernel-devel kernel-headers;

yum -y install perl
rm -f /tmp/chef*rpm
if [ "$distro" != 'redhat' ]; then
  yum -y clean all;
fi

# clean up redhat interface persistence
rm -f /etc/udev/rules.d/70-persistent-net.rules
mkdir -p /etc/udev/rules.d/70-persistent-net.rules;
rm -f /lib/udev/rules.d/75-persistent-net-generator.rules;
rm -rf /dev/.udev/;

for ndev in `ls -1 /etc/sysconfig/network-scripts/ifcfg-*`; do
    if [ "`basename $ndev`" != "ifcfg-lo" ]; then
        sed -i '/^HWADDR/d' "$ndev";
        sed -i '/^UUID/d' "$ndev";
    fi
done

curl https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub > ~vagrant/.ssh/authorized_keys
chmod og-rw ~vagrant/.ssh/authorized_keys
chown vagrant.vagrant ~vagrant/.ssh/authorized_keys


rm -f VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?;
rm -f /tmp/chef*rpm
