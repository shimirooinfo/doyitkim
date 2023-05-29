#
# add host to vcenter
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
	$StorageFile=$f.path+$f.FileName
	$esxcli = Get-Esxcli -vmhost $f.alias -v2
	$esxcli.software.vib.update($StorageFile,$false,$true,$true,$true,$false,$null,$null,$null)
}
Disconnect-VIServer -Server * -Force -confirm:$false
