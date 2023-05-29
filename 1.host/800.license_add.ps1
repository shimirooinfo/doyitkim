#
# add host to vcenter
#
$VcInfoFile = "$HOME/scripts/0.target/vcenter_vc70.csv"
$TgtFile = "$HOME/scripts/0.target/tgt_s80_all.csv"
#
# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
#foreach ($VcInfo in (import-csv -path $VcInfoFile))
#{
#	Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
#}

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip
	connect-viserver -server $f.ip -user root -password vmware1! 
	#
	$lm = Get-View -Id 'LicenseManager-ha-license-manager'
	$lm.UpdateLicense("TH087-0WK0K-3868T-026RM-958QN", $null)


}
