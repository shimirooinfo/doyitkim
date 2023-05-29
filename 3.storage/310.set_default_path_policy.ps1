#
# Set default path policy
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
	echo $f.alias
	$esxcli = Get-Esxcli -vmhost $f.alias
	$esxcli.storage.nmp.satp.set($true,"VMW_PSP_RR","VMW_SATP_ALUA")
}

Disconnect-VIServer -Server * -Force -confirm:$false
