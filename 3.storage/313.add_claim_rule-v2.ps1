#
# Add Claim rule
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip
	$esxcli = Get-Esxcli -vmhost $f.alias -V2
	$satpArgs = $esxcli.storage.nmp.satp.rule.add.createArgs()
	$satpArgs.vendor = "DGC"
	$satpArgs.satp = "VMW_SATP_ALUA_CX"
	$satpArgs.psp = "VMW_PSP_RR"
	$satpArgs.pspoption = "iops=1"
	$satpArgs.claimoption = "tpgs_on"
	$esxcli.storage.nmp.satp.rule.add.invoke($satpArgs)
	$esxcli.storage.nmp.satp.rule.remove.invoke($satpArgs)
}
Disconnect-VIServer -Server * -Force -confirm:$false
