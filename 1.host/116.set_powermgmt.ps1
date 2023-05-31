# 
# Set to the high performance 
# 
. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip
	$view = (Get-VMhost $f.ip |get-view)
	(get-view $view.ConfigManager.PowerSystem).ConfigurePowerPolicy(1)
}
Disconnect-VIServer -Server * -Force -confirm:$false
