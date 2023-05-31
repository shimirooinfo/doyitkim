#
# Ignore HA notify message
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.cluster
	New-advancedsetting -entity $f.cluster -Type ClusterHA -Name 'das.ignoreInsufficientHbDatastore' -Value true -confirm:$false
}
Disconnect-VIServer -Server * -Force -confirm:$false
