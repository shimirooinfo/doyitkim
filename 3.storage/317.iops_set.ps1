#
# Set IOPS
#
# target 파일을 매개변수로 받을때 아래 주석 해제
#
#Param(
#        [Parameter(Mandatory=$True,Position=1)]
#        [string]$targetfile
#)
# target 파일을 매개변수로 받을때 아래 주석 처리

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
