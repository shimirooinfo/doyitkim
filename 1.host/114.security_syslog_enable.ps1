#
# Name of the scripts
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip
	get-vmhost $f.alias |Get-VMHostFirewallException | Where {$_.Name -eq "syslog"} | Set-VMHostFirewallException -Enabled $true -Confirm:$false
}
Disconnect-VIServer -Server * -Force -confirm:$false
