### Check winRM endpoint is accessible

`knife wsman test <DNS label>.<location>.cloudapp.azure.com -m --winrm-transport ssl --winrm-ssl-verify-mode verify_none`   

```
[root@45ec23b8a691 /]# knife wsman test winseb2012h.westeurope.cloudapp.azure.com -m --winrm-transport ssl --winrm-ssl-verify-mode verify_none
WARNING: No knife configuration file found
WARNING: * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
SSL validation of HTTPS requests for the WinRM transport is disabled. HTTPS WinRM
connections are still encrypted, but knife is not able to detect forged replies
or spoofing attacks.

To fix this issue add an entry like this to your knife configuration file:

  # Verify all WinRM HTTPS connections (default, recommended)
  knife[:winrm_ssl_verify_mode] = :verify_peer
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
Connected successfully to winseb2012h.westeurope.cloudapp.azure.com at https://winseb2012h.westeurope.cloudapp.azure.com:5986/wsman.
```

### Check winRM authentication
`knife winrm -m winseb2012h.westeurope.cloudapp.azure.com ipconfig -x USER -P PASSWORD -t ssl --winrm-ssl-verify-mode verify_none`

### Configure your Chef Server
You need to either create a Chef server or register an account at hosted chef (https://manage.chef.io).     
You can follow instructions here: https://learn.chef.io/manage-a-node/windows/set-up-your-chef-server/   

* Update the `provisioning/chef/.chef/default.rb` with your node name, ...  
* Copy your private key (PEM file) into `provisioning/chef/.chef`  

### Bootstrap node
Asuming you call your node `win_web`, you can now bootstrap it with this command:    
`knife bootstrap windows winrm winseb2012h.westeurope.cloudapp.azure.com -x USER -P PASSWORD -t ssl --winrm-ssl-verify-mode verify_none -N win_web`

### Get the community cookbooks our cookbook depends on
```
 cd provisioning/chef/cookbooks && \
 for p in chef_handler windows chocolatey webpi; do knife cookbook site download $p && tar -zxvf $p-*.gz && rm -rf $p-*.gz; done
```

### Upload the cookbooks to your Chef server (hosted or private)
```
 cd provisioning/chef/cookbooks && \
 for p in chef_handler windows chocolatey webpi; do knife upload $p; done
```

### Run the cookbook on your node
`knife winrm -m winseb2012h.westeurope.cloudapp.azure.com chef-client --manual-list -x USER -P PASSWORD -t ssl --winrm-ssl-verify-mode verify_none`

