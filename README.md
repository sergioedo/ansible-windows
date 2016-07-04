
# ansible-windows
Use ansible for manage windows servers from a windows client.

## Prerequisities

Ansible requires linux in the client machine (manager node), so you will need a virtual environment for the client:

* Virtualbox
* Vagrant

In windows servers, you must enable remote connections with PowerShell.

Follow next steps for configuration.

## Running

### On remote managed server
* Requires PowerShell 3.0 installed (from powershell terminal, run: $PSVersionTable.PSVersion). Note: requires Windows Feature "Windows PowerShell Integrated Scripting Environment (ISE)". 
* Launch powershell terminal (run as administrator)
* You can try to upgrade from powershell 2.0 with the script ['powershell/upgrade_to_ps3.ps1'](https://github.com/ansible/ansible/blob/devel/examples/scripts/upgrade_to_ps3.ps1).
* Allow [powershell execution](http://www.howtogeek.com/106273/how-to-allow-the-execution-of-powershell-scripts-on-windows-7/)
```
Set-ExecutionPolicy Unrestricted
```
* Execute script ['powershell/ConfigureRemotingForAnsible.ps1'](https://github.com/ansible/ansible/blob/devel/examples/scripts/ConfigureRemotingForAnsible.ps1) (SkipNetworkProfileCheck param needed for private/domain network and public network are defined on the server).
```
./ConfigureRemotingForAnsible.ps1 -SkipNetworkProfileCheck
```
* Revert allow powershell execution 
```
Set-ExecutionPolicy Restricted
```

Now server is ready to be managed by ansible (with win remote connection).

### On manager node (with vagrant)
* Install VirtualBox + Vagrant
* Edit 'Vagrantfile', to point to the local path of this project on your disk. Then, inside vagrant environment, you can acces to this project resources in /src.

```
...
config.vm.synced_folder "c:/src/ansible-windows", "/src"
...
```

* Edit <this_project>/hosts, at the end of the file, add your remote host to manage in a list (in this example 'windows'):
```
[windows]
server-name1
server-name2
server-name3
```
* Edit group_vars/windows.yml, replacing {domain_name}, {domain_user} and {password} with valid credentials to connect windows servers.
```
# it is suggested that these be encrypted with ansible-vault:
# ansible-vault edit group_vars/windows.yml

ansible_user: {domain_name}\{domain_user}
ansible_password: {user_password}
ansible_port: 5986
ansible_connection: winrm
# The following is necessary for Python 2.7.9+ when using default WinRM self-signed certificates:
ansible_winrm_server_cert_validation: ignore
# Define transport, like here: https://github.com/diyan/pywinrm#run-process-with-low-level-api-with-domain-user-disabling-https-cert-validation
ansible_winrm_transport: ntlm
```

* Run virtual environment:
```
vagrant up
```
* Connect via console:
```
vagrant ssh
```
* Go to project base directory:
```
cd /src
```
* Test it! Get facts from server, it must return a json with server info.
```
ansible {server-name} -m setup
```

