# Very simple deployment of an Windows VM

Based on the template done by coreysa (https://github.com/coreysa).   
(It's mostly a stripped-down version of the original with an additional Network Security group and winRM SSL activation)  

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsebbrochet%2Fazure_win%2Fmaster%2Fvm_creation%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fsebbrochet%2Fazure_win%2Fmaster%2Fvm_creation%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to deploy a Windows 2012 Server R2 VM, using the latest patched version. This will deploy in the location of the resource group you run it and use a D1 VM Size.
