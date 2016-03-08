# Some testing with Ansible to configure a Windows Server 2012 R2 server hosted in Azure...

### VM creation on Azure
* You can either
  * Browse to https://github.com/sebbrochet/azure_win/tree/master/vm_creation and click on the **Deploy to Azure** button
  * or use Azure cli
    * `azure group create RESOURCE_GROUP_NAME LOCATION`
    * ex: `azure group create winseb2012e westeurope`
    * `azure group deployment create --template-uri https://raw.githubusercontent.com/sebbrochet/azure_win/master/vm_creation/azuredeploy.json RESOURCE_GROUP_NAME firstDeployment`
    * ex: `azure group deployment create --template-uri https://raw.githubusercontent.com/sebbrochet/azure_win/master/vm_creation/azuredeploy.json winseb2012e firstDeployment`

You'll need to provide username, password and DNS label for the VM.   

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

### Check the result
Browse `http://<your DNS label>.<your location>.cloudapp.azure.com`   
Ex: http://winseb2012g.westeurope.cloudapp.azure.com   

You should get Tomcat 8 default home page!   


