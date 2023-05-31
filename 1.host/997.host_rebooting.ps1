#
# restart to host
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	Restart-VMhost $f.alias -RunAsync -force:$true -confirm:$false

}
Disconnect-VIServer -Server * -Force -confirm:$false
