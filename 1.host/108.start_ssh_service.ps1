#
# ssh start to host
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	get-vmhost $f.alias |Get-VMHostService | Where {$_.Key -eq "TSM-SSH"} | Set-VMHostService -Policy "On" |Start-VMHostService
}
Disconnect-VIServer -Server * -Force -confirm:$false
