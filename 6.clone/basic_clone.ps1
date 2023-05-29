#
# clone vm
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

$MstTmpl = "test-d80-image"
$CsSpec = "linux-cs"
$CsSpec_temp = "linux-cs-temp"

New-OSCustomizationSpec -OScustomizationSpec $CsSpec -name $CsSpec_temp
foreach ($f in (import-csv -path $TgtFile ))
{
	Get-OSCustomizationNicMapping -Spec $CsSpec_temp | Set-OSCustomizationNicMapping -IpMode UseStaticIp -IpAddress $f.ip -SubnetMask 255.255.240.0 -DefaultGateway $f.gateway
	Write-host "Deploying VM " -ForegroundColor Green -NoNewline; Write-Host $f.vm -ForegroundColor Yellow
	New-VM  -VMhost $f.host -Name $f.vm -Template $MstTmpl -OSCustomizationSpec $CsSpec_temp -Datastore $f.ds
	Start-VM  -VM $f.vm
}
Remove-OSCustomizationSpec $CsSpec_temp -Confirm:$false
Disconnect-VIServer -Server * -Force -confirm:$false
