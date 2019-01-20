<# The following instructions cover setting up Docker on Windows Server 2016 #>

# Enable PS Remoting on TARGET
Enable-PSRemoting -Force

# Allow trustedhosts on both SOURCE and TARGET
Set-Item WSMan:\localhost\Client\TrustedHosts *

# Restart WinRM service on TARGET
Restart-Service -Name WinRM

$targetName = "172.27.119.43"

# Test Connection from SOURCE
Test-WSMan -ComputerName $targetName

<#

    wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
    ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
    ProductVendor   : Microsoft Corporation
    ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 3.0

#>

# Build up session and connect
$credential = Get-Credential Administrator
$session = New-PSSession -ComputerName $targetName -Credential $credential
Enter-PSSession -Session $session

# Enable and run Windows Updates
Install-Module -Name WSWindowsUpdate -Force

# Check it's installed
Get-Command -Module PSWindowsUpdate

# Add Microsoft Update ServiceIns
# EDIT: don't think this is needed so have commented out
# Add-WUServiceManager -Confirm -ServiceID "7971f918-a847-4430-9279-4a52d1efe18d"

# Install all updates
Install-WindowsUpdate -AcceptAll -AutoReboot -WindowsUpdate -MicrosoftUpdate -Verbose

# Install containers feature and restart
Install-WindowsFeature -Name Containers -Restart

# Apparently Docker Daemon (dockerd) is included with Windows Server 2016+ these days.

# Check running
Get-Service -Name docker

# both client and server should be running natively on windows OS
docker version

# Install "ContainerImage" Package Provider for Windows Server base image
Install-PackageProvider -Name ContainerImage -Force

# Test
Find-ContainerImage

<#



#>

# Install WindowsServerCore
Install-ContainerImage -Name WindowsServerCore

docker image list
<#



#>

