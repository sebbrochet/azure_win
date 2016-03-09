### Check Ansible - Windows VM connection
* Replace the configuration file with the provided configuration file sample
  * `cp provisioning/ansible/group_vars/windows_hosts.yml.sample provisioning/ansible/group_vars/windows_hosts.yml`
* Update it with the windows VM credentials
* You should also update the inventory file (`provisioning/ansible/azure_hosts`) with the DNS of the windows server you want to configure.
* Run
  * `ansible all -i provisioning/ansible/azure_hosts -m setup`
* As this file contains your credentials, you should encrypt it wih ansible-vault
  * `ansible-vault encrypt provisionin/ansible/group_vars/windows_hosts.yml`

### Provision the VM with Ansible
The provided ansible playbook:
* Install IIS feature
* Install Tomcat 8
* Configure IIS to act as a reverse-proxy for Tomcat (http://localhost:8000)

To provision your windows server, go the `provisioning/ansible` directory and run:
`ansible-playbook -i azure_hosts windows2012.yml --ask-vault`
