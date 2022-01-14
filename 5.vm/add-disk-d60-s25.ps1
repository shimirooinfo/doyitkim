# clone vm

$vcinfofile ="C:\scripts.v5\01_target\vcenter.csv"
$targetfile ="C:\scripts.v5\00_clone\target\d60-s25.csv"

# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
foreach ($v in (import-csv -path $vcinfofile))
{
	Connect-VIServer -Server $v.vc -user $v.user -password $v.passwd -Protocol https
}
foreach ($f in (import-csv -path $targetfile ))
{
	New-harddisk -vm $f.name -CapacityGB 50 -Datastore $f.datastore
}
Disconnect-VIServer -Server * -Force -confirm:$false
