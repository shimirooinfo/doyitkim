#
# Set IOPS
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$esxcli = Get-Esxcli -vmhost $f.alias
	$iops="1"
	$type="iops"

	foreach ($a in ($esxcli.storage.nmp.device.list() | select device | where-object {$_.Device -like "naa.60*"}))
	{
		$esxcli.storage.nmp.psp.roundrobin.deviceconfig.set($null,$null,$a.Device,$iops,$type,$null)
	}

}
Disconnect-VIServer -Server * -Force -confirm:$false
