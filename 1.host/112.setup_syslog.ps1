#
# Disable SSH Warning Message 
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	Set-VMHostSyslogServer -SyslogServer 10.15.73.147:514 -VMhost $f.alias

}
Disconnect-VIServer -Server * -Force -confirm:$false
