#!/bin/bash

export VM=win2008_r2
export BOX=vladistan/$VM

vagrant box update --provider vmware_fusion
vagrant up --provider vmware_fusion
vagrant halt

export VMX_NAME=`cat .vagrant/machines/default/vmware_fusion/id`
echo $VMX_NAME

packer build vsphere.json
