#
# Start All VM
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	get-cluster $f.clstlist |get-vm |start-vm -Runasync -confirm:$false |Out-Null

}
Disconnect-VIServer -server * -force -confirm:$false
