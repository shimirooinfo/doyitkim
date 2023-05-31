#
# HA Admission Enable
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.cluster
	get-cluster $f.cluster | Set-cluster -HAenabled $true -confirm:$false  | Set-cluster -HAAdmissionControlenabled $false -confirm:$false
}
Disconnect-VIServer -Server * -Force -confirm:$false
