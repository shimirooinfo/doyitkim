# 
# Enable the Software iSCSI Initiator
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	Get-VMHostStorage -VMHost $f.alias |Set-VMHostStorage -SoftwareIScsiEnabled $true
}
Disconnect-VIServer -Server * -Force -confirm:$false
