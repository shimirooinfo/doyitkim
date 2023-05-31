#
# ssh re-start to host
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip
	get-vmhost $f.alias |Get-VMHostService | Where {$_.Key -eq "ntpd"} | stop-VMHostService -confirm:$false
	get-vmhost $f.alias |Get-VMHostService | Where {$_.Key -eq "ntpd"} | start-VMHostService 
}
Disconnect-VIServer -Server * -Force -confirm:$false
