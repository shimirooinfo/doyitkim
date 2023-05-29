#
# Set Delayed Ack to Disable
#
# target 파일을 매개변수로 받을때 아래 주석 해제
#
#Param(
#        [Parameter(Mandatory=$True,Position=1)]
#        [string]$targetfile
#)
# target 파일을 매개변수로 받을때 아래 주석 처리

. "$HOME/scripts/globalval.ps1"

# Connect to the vCenter Server
foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
        Write-host "Connecting to vCenter Server: " -ForegroundColor Green -NoNewline; Write-Host $VcInfo.vc -ForegroundColor Yellow
        Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$esxcli = Get-Esxcli -vmhost $f.alias
	$vmhba=Get-VMhost $f.alias | Get-VMHostHBA -Type Iscsi | Select Device
	$Key="DelayedAck"
	$value="0"
}

foreach ($a in ($vmhba))
{
	$esxcli.iscsi.adapter.param.set($a.Device, $null, $Key, $value)
}
Disconnect-VIServer -Server * -Force -confirm:$false
