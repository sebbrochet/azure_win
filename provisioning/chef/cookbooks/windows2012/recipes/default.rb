#
# Cookbook Name:: windows2012
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{ IIS-WebServerRole IIS-WebServer }.each do |feature|
  windows_feature feature do
    action :install
  end
end

service 'w3svc' do
  action [:start, :enable]
end

file 'C:\inetpub\wwwroot\iisstart.htm' do
  action :delete
end

template 'C:\inetpub\wwwroot\index.html' do
  source 'index.html.erb'
end 

include_recipe 'chocolatey'

%w{ tomcat lessmsi }.each do |package|
  chocolatey package
end

include_recipe 'webpi'

%w{ URLRewrite2 ARRv3_0 }.each do |product|
  webpi_product product do
    accept_eula true
    action :install
  end
end

powershell_script 'enable_arr_proxy' do
  code 'Set-WebConfigurationProperty -pspath MACHINE/WEBROOT/APPHOST -filter "system.webServer/proxy" -name "enabled" -value "True"'
  #only_if '(Get-WebConfigurationProperty -pspath MACHINE/WEBROOT/APPHOST -filter "system.webServer/proxy" -name "enabled").value -eq "False"'
end

template 'C:\inetpub\wwwroot\web.config' do
  source 'web.config.erb'
end 
