#
# Add an iSCSI target
#

. "$HOME/scripts/globalval.ps1"

#$sw_iscsi_dev = "vmhba64"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$hba = Get-VMhost $f.alias |Get-VMHostHba -Type IScsi | Where {$_.Model -eq "iSCSI Software Adapter"}
	New-IScsiHbaTarget -IScsiHba $hba -Address $f.tgt1
	New-IScsiHbaTarget -IScsiHba $hba -Address $f.tgt2
	New-IScsiHbaTarget -IScsiHba $hba -Address $f.tgt3
	New-IScsiHbaTarget -IScsiHba $hba -Address $f.tgt4
}
Disconnect-VIServer -Server * -Force -confirm:$false
