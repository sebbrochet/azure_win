# Some testing with Ansible to configure a Windows Server 2012 R2 server hosted in Azure...

### VM creation on Azure
* Browse to https://github.com/sebbrochet/azure_win/tree/master/vm_creation and click on the **Deploy to Azure** button

You'll need to provide username, password and DNS label for the VM.   

### VM preparation for Ansible configuration
* All is described in details here: http://docs.ansible.com/ansible/intro_windows.html#windows-system-prep 
* On a Windows Server 2012 R2 VM, it means you only need to run this Powershell script https://github.com/ansible/ansible/blob/devel/examples/scripts/ConfigureRemotingForAnsible.ps1
* Connect to your Windows VM using the RDP link provided in the Azure portal (Connect)
* Open Windows Powershell and type `notepad ConfigureRemotingForAnsible.ps1`
* Launch Internet Exlporer and browse to the raw version of the Powershell script to run (https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1)
* Select all source code and copy it (CTRL+A, CTRL+C)
* Paste it into notepad, save file and exit
* In the powershell windows, execute the script
  * `.\ConfigureRemotingForAnsible.ps1`
* You VM is now ready to be Ansible controlled ;)

### Check Ansible - Windows VM connection
* Replace the configuration file with the provided configuration file sample 
  `cp provisioning/group_vars/windows_hosts.yml.sample provisioning/group_vars/windows_hosts.yml`
* Update it with the windows VM credentials
* You should also update the inventory file (provisioning/azure_hosts) with the DNS of the windows server you want to configure.   
* Run
  `ansible all -i provisioning/azure_hosts -m setup`
* As this file contains your credentials, you should encrypt it wih ansible-vault
  `ansible-vault encrypt provisioning/group_vars/windows_hosts.yml`

### Provision the VM with Ansible
The provided ansible playbook:   
* Install IIS feature
* Install Tomcat 8
* Configure IIS to act as a reverse-proxy for Tomcat (http://localhost:8000)
   
To provision your windows server, go the provisioning directory and run:  
`ansible-playbook -i azure_hosts windows2012.yml --ask-vault`

### TODO
* Contrary to a Windows Server 2012 R2 directly provisioned from the Market place with the portal, the template doesn't currently include a Network Security Group. As such, there is no sense to proxify Tomcat as it's directly accessible at http://your_public_ip:8080
  * => add a Network Secuiry Group in the Azure template
