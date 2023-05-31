#
# esxcli software profile update 
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip
	$esxcli = Get-Esxcli -vmhost $f.ip -v2
	$arguments = $esxcli.software.profile.update.CreateArgs()
	$arguments.depot = $f.path+$f.FileName
	$arguments.profile = “DEL-ESXi-702_17867351-A05”
	$esxcli.software.profile.update.Invoke($arguments)
}
Disconnect-VIServer -Server * -Force -confirm:$false
