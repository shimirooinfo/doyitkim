#
# get esxi version
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$esxcli = Get-Esxcli -vmhost $f.alias -V2
	$esxcli.system.version.get.invoke()
}

Disconnect-VIServer -Server * -Force -confirm:$false
