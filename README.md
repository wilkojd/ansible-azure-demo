# Ansible-azure-demo
The scripts in this repo showcase some of what can be achieved using Ansible modules to manage resources on Azure.

## Setup & Pre-requisites

### Ansible
To use the Ansible scripts in this repo, you will need Ansible installed. I've been working with 2.3.0.0. The Ansible documentation is very comprehensive: https://docs.ansible.com/ansible/intro_installation.html 

The steps to set this up on macOS are:
1. Ensure python & pip are installed. For example, `python --version` returns `Python 2.7.10`. `pip --version` returns `pip 9.0.1`
2. Install Ansible `sudo pip install ansible`
3. Install Azure python SDK `sudo pip install "azure==2.0.0rc5”`
4. Ensure python bin folder is on the PATH. You should see something like `/Library/Frameworks/Python.framework/Versions/2.7/bin` in the output from `echo $PATH`
5. Turn off strict host key checking by adding an Ansible config file at ~/.ansible.cfg
```
[defaults]
host_key_checking = False
```
6. Confirm Ansible is available. `ansible --version` returns `ansible 2.3.0.0`

### Azure
1. Create a *service principal* application with an existing Azure account and assign it as an owner of the Azure account, in order to authenticate Ansible with Azure account. The steps to do this are detailed at https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal . **N.B. The URL for the application does not have to be a working URL, see http://blog.davidebbo.com/2014/12/azure-service-principal.html.**
2. From the Azure portal, get the required values of client_id (the app id), secret, and tenant, as per instructions in official Azure article from step 1), and the subscription_id (found in billing/subscriptions). Save them into ~/.azure/credentials like this:

```
[default]
subscription_id=
client_id=
secret=
tenant=
```

## Usage

- To setup two new VMs in Azure, run `ansible-playbook create-vms.yml`
- To grant access to these VMs to a new keypair, run `./add-new-user.sh`. The private key `newuserkey` can then be used to login to the VMs using a command like `ssh -i newuserkey azure_user@host`
- To revoke access to these VMs for the key, ensure the newuserkey.pub file is still present, then run `ansible-playbook manage-user-key.yml --extra-vars="user_state=absent"`
- To delete all of the resources generated in Azure, run `ansible-playbook remove-all.yml`
- To change the name of the resource group, the admin user created on the VMs, or the Ansible host group containing the VMs, edit vars.yml