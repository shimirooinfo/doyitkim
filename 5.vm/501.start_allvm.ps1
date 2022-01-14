#
# restart to host
#
$VcInfoFile = "../0.target/vcenter_vc70.csv"
$TgtFile = "../0.target/tgt_s80_all.csv"

# Connect to the vCenter Server
"{0} Connecting to vcenter server..."

foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
                Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}


foreach ($f in (import-csv -path $TgtFile))
{
	get-cluster $f.clstlist |get-vm |start-vm -Runasync -confirm:$false |Out-Null

}
Disconnect-VIServer -server * -force -confirm:$false
