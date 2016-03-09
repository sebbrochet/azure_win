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

### Provisiong step
* You can either provision your node with Ansible or Chef
  * For Ansible, please have a look at [provisioning/ansible](tree/master/provisioning/ansible)
  * For Chef, please have a look at [provisioning/chef](tree/master/provisioning/chef)
* In each case the playbook/cookbook will
  * Install IIS feature
  * Install Tomcat 8
  * Configure IIS to act as a reverse-proxy for Tomcat (http://localhost:8000)

### Check the result
Browse `http://<your DNS label>.<your location>.cloudapp.azure.com`   
Ex: http://winseb2012g.westeurope.cloudapp.azure.com   

You should get Tomcat 8 default home page!   

