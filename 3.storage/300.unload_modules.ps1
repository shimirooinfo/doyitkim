#
# Unload module
#

. "$HOME/scripts/globalval.ps1"
#

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$esxcli = Get-Esxcli -vmhost $f.alias
	$esxcli.system.module.set($false, $false, $unload_module1 ) 
	$esxcli.system.module.set($false, $false, $unload_module2 ) 
}

Disconnect-VIServer -Server * -Force -confirm:$false
