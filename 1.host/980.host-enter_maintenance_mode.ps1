#
# Enter/Exit  mainternance mode 
# Maintenace = enter maintenance mode
# Connected = exit maintenance mode
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip 
	#
	# Enter Maintenance Mode
	#
	#Set-VMHost  $f.ip -State "Maintenance" -confirm:$false
	#
	# Exit Maintenance Mode
	#
	Set-VMHost  $f.alias -State "Connected" -confirm:$false
	
}
Disconnect-VIServer -Server * -Force -confirm:$false
