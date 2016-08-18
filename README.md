# qa-jenkins-onmetal
### OSIC Ops/QA Automation PoC for CI/CD

This repository describes the installation of a full OpenStack deployment using a single OnMetal host from the Rackspace Public Cloud. This is a multi-node installation using VMs that have been PXE booted which was done to provide an environment that is almost exactly what is in production.

Ansible scripts here can create a Rackspace OnMetal I/O v2 server build, prepare the OnMetal server, kick and deploy OpenStack using KVM, Cobbler, and OpenStack-Ansible within 15 VM Nodes(3 infra, 3 logging, 3 compute, 3 cinder, 3 swift).

End to end flow is automated via jenkins pipeline (See jenkins/pipeline.groovy) which can be run on a Jenkins Agent Server.

We assume a Jenkins master and Jenkins Agent servers are available (agent can be created on the fly - see below requirements -

##### Rackspace Public Cloud Credentials  
_.raxpub_ file **in the repo directory** formatted like this:  
```shell
[rackspace_cloud]
username = your-cloud.username
api_key = e1b835d65f0311e6a36cbc764e00c842
```

##### Jenkins Agent

OSIC QA prepares a jenkins agent from where the flow will start and has following dependencies installed:

 Packages
+ apt-get
  + python-dev
  + build-essential
  + libssl-dev
  + curl
  + git
  + pkg-config
  + libvirt-dev
+ pip [ python <(curl -sk https://bootstrap.pypa.io/get-pip.py) ]
  + ansible >= 2.0
  + lxml
  + pyrax
  + libvirt-python
+ rack binary
  + [installation and configuration](https://developer.rackspace.com/docs/rack-cli/configuration/#installation-and-configuration)

##### SSH Key Pair  
```shell
mkdir /root/.ssh
ssh-keygen -q -t rsa -N "" -f /root/.ssh/id_rsa
```

### Usage
##### Optional
```shell
# NOT Confirmed
ansible-playbook setup_master.yaml

# NOT Confirmed
ansible-playbook setup_jenkins.yaml
```

##### Jenkins Pipeline
tags available are _iad_ and _dfw_, **without** tags resources are created in **both** regions

See also jenkins/pipeline.groovy

```shell
# Confirmed
ansible-playbook build_onmetal.yaml --tags 'iad'

# Confirmed
ansible-playbook -i hosts get_onmetal_facts.yaml --tags 'iad'

# Confirmed
ansible-playbook -i hosts prepare_onmetal.yaml

# Confirmed
ansible-playbook -i hosts set_onmetal_cpu.yaml

# Confirmed
ansible-playbook -i hosts configure_onmetal.yaml

# Confirmed
ansible-playbook -i hosts create_lab.yaml

# Confirmed
ansible-playbook -i hosts prepare_for_osa.yaml

# Confirmed
ansible-playbook -i hosts deploy_osa.yaml

# Confirmed
ansible-playbook -i hosts destroy_virtual_machines.yaml

# Confirmed
ansible-playbook -i hosts destroy_virtual_networks.yaml

# Confirmed
ansible-playbook -i hosts destroy_lab_state_file.yaml

# Confirmed
ansible-playbook -i hosts destroy_onmetal.yaml --tags 'iad'
```
