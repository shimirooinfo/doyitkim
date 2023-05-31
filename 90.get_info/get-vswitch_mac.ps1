# 
# ESXi Kernel Network Mac addresss  ¼öÁý Scripts
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $targetfile))
{
	echo "############################################"
 	echo $f.alias 
	echo "############################################"
 	get-vmhost $f.alias | Get-VMHostNetworkAdapter -vmkernel | format-table -Autosize -property Mac, PortGroupName, VMHost, IP 
 
}
Disconnect-VIServer -Server * -Force -confirm:$false
