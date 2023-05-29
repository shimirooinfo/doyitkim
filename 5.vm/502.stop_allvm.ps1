#
# restart to host
#

. "$HOME/scripts/globalval.ps1"

#
# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
                Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}

foreach ($f in (import-csv -path $TgtFile))
{
	get-cluster $f.clstlist |get-vm |shutdown-vmguest -confirm:$false |Out-Null

}
Disconnect-VIServer -server * -force -confirm:$false
