# Some testing with Ansible to configure a Windows Server 2012 R2 server hosted in Azure...

The provided ansible playbook:   
* Install IIS feature
* Install Tomcat 8
* Configure IIS to act as a reverse-proxy for Tomcat (http://localhost:8000)
   
provisioning/group_vars/windows_hosts.yml is/should be vault-protected as it contains credentials.   
You should update it with yours based on this template (provisioning/group_vars/windows_hosts.yml.sample)    
You should also update the inventory file (provisioning/azure_hosts) with the DNS of the windows server you want to configure.   
   
To provision your windows server, go the provisioning directory and run:  
`ansible-playbook -i azure_hosts windows2012.yml --ask-vault`
