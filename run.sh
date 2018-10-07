#!/bin/bash

export VM=centos-74-x86_64-min
export BOX=vladistan/$VM

vagrant init $BOX
vagrant box update --provider vmware_fusion
vagrant up --provider vmware_fusion
vagrant halt

export VMX_NAME=`cat .vagrant/machines/default/vmware_fusion/id`
echo $VMX_NAME

packer build vsphere.json
