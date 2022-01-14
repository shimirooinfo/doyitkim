# clone vm

$master = "tmpl-nuvm"

$vcinfofile ="C:\scripts.v3\01-target\vcenter.csv"
$targetfile ="C:\scripts.v3\80-VM\target\clone.csv"

$tempspecname ="temp-naver"

# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
foreach ($v in (import-csv -path $vcinfofile))
{
	Connect-VIServer -Server $v.vc -user $v.user -password $v.passwd -Protocol https
}

New-OSCustomizationSpec -OScustomizationSpec linux64 -Name $tempspecname
foreach ($f in (import-csv -path $targetfile ))
{
	Get-OSCustomizationNicMapping -Spec $tempspecname | Set-OSCustomizationNicMapping -IpMode UseStaticIp -IpAddress $f.ip -SubnetMask 255.255.255.0 -DefaultGateway $f.gateway
	New-VM  -VMhost $f.host -Name $f.name -Template $master -OSCustomizationSpec $tempspecname -Datastore $f.datastore
#	Start-VM  -VM $f.name
}
Remove-OSCustomizationSpec $tempspecname -Confirm:$false
Disconnect-VIServer -Server * -Force -confirm:$false
