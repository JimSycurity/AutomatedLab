#This intro script is pretty almost the same like the previous one. But this lab is connected to the internet over the external virtual switch.
#The IP addresses are assigned automatically like in the previous samples but AL also assignes the gateway and the DNS servers to all machines
#that are part of the lab. AL does that if it finds a machine with the role 'Routing' in the lab.

New-LabDefinition -Name 'Lab0' -DefaultVirtualizationEngine HyperV

Add-LabVirtualNetworkDefinition -Name xLab0
Add-LabVirtualNetworkDefinition -Name External -HyperVProperties @{ SwitchType = 'External'; AdapterName = 'Wi-Fi' }

Add-LabMachineDefinition -Name xDC1 -Memory 1GB -OperatingSystem 'Windows Server 2016 SERVERDATACENTER' -Roles RootDC -Network xLab0 -DomainName contoso.com

$netAdapter = @()
$netAdapter += New-LabNetworkAdapterDefinition -VirtualSwitch xLab0
$netAdapter += New-LabNetworkAdapterDefinition -VirtualSwitch External -UseDhcp
Add-LabMachineDefinition -Name xRouter1 -Memory 1GB -OperatingSystem 'Windows Server 2016 SERVERDATACENTER' -Roles Routing -NetworkAdapter $netAdapter -DomainName contoso.com

Add-LabMachineDefinition -Name xClient1 -Memory 1GB -Network xLab0 -OperatingSystem 'Windows 10 Pro' -DomainName contoso.com

Install-Lab

Show-LabInstallationTime