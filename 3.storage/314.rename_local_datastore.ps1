#
# Rename Local Datastore
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	get-vmhost $f.alias |get-datastore |where-object {$_.Name -like "datastore*"} |Set-Datastore -Name  $f.datastore
}
Disconnect-VIServer -Server * -Force -confirm:$false
