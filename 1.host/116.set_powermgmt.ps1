# 
# Set to the high performance 
# 
. "$HOME/scripts/globalval.ps1"
#
# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
	Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip
	$view = (Get-VMhost $f.ip |get-view)
	(get-view $view.ConfigManager.PowerSystem).ConfigurePowerPolicy(1)
}
Disconnect-VIServer -Server * -Force -confirm:$false
