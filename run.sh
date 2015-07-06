#!/bin/bash

BOX=vladistan/win7

vagrant init vladistan/win7
vagrant box update --provider vmware_fusion 
vagrant up --provider vmware_fusion

export VMX_NAME=`cat .vagrant/machines/default/vmware_fusion/id`
echo $VMX_NAME


