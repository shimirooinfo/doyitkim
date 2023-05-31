#
# Set default path policy
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$esxcli = Get-Esxcli -vmhost $f.alias -V2
	$TmpArgs = $esxcli.storage.nmp.satp.set.CreateArgs()
	$TmpArgs.satp = "VMW_SATP_ALUA"
	$TmpArgs.defaultpsp ="VMW_PSP_RR" 
	$TmpArgs.boot = "$true"
	$esxcli.storage.nmp.satp.set.invoke($TmpArgs)
}
Disconnect-VIServer -Server * -Force -confirm:$false
