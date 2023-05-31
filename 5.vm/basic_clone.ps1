#
# clone vm
#

. "$HOME/scripts/globalval.ps1"

$MstTmpl = "test-d80-image"
$CsSpec = "linux-cs"
$CsSpec_temp = "linux-cs-temp"

$TgtClone = "$HOME/scripts/0.target/tgt-clone.csv"

New-OSCustomizationSpec -OScustomizationSpec $CsSpec -name $CsSpec_temp
foreach ($f in (import-csv -path $TgtClone ))
{
	Get-OSCustomizationNicMapping -Spec $CsSpec_temp | Set-OSCustomizationNicMapping -IpMode UseStaticIp -IpAddress $f.ip -SubnetMask 255.255.240.0 -DefaultGateway $f.gateway
	Write-host "Deploying VM " -ForegroundColor Green -NoNewline; Write-Host $f.vm -ForegroundColor Yellow
	New-VM  -VMhost $f.host -Name $f.vm -Template $MstTmpl -OSCustomizationSpec $CsSpec_temp -Datastore $f.ds
	Start-VM  -VM $f.vm
}
Remove-OSCustomizationSpec $CsSpec_temp -Confirm:$false
Disconnect-VIServer -Server * -Force -confirm:$false
