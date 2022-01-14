# clone vm

$vcinfofile ="C:\scripts.v3\01-target\vcenter.csv"
$targetfile ="C:\scripts.v3\80-VM\target\d50-s4.csv"

# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
foreach ($v in (import-csv -path $vcinfofile))
{
	Connect-VIServer -Server $v.vc -user $v.user -password $v.passwd -Protocol https
}
foreach ($f in (import-csv -path $targetfile ))
{
	echo $f.name
	Get-Harddisk -vm $f.name -Name "하드 디스크 2" |remove-harddisk -deletepermanently -confirm:$false
}
Disconnect-VIServer -Server * -Force -confirm:$false
