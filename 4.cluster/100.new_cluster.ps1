#
# Create New Cluster or Remove Cluster
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	New-Cluster -Location $f.location  -Name $f.clstlist
	#
	# Remove-Cluster -Location $f.location -Name $f.clstlist
	#
}
Disconnect-VIServer -Server * -Force -confirm:$false
