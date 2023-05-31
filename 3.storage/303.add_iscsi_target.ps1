#
# Add an iSCSI target
#

. "$HOME/scripts/globalval.ps1"

$sw_iscsi_dev = "vmhba64"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip
	Get-VMHost $f.alias | get-vmhosthba -device $sw_iscsi_dev | New-IScsiHbaTarget -Address $f.tgt1 
	Get-VMHost $f.alias | get-vmhosthba -device $sw_iscsi_dev | New-IScsiHbaTarget -Address $f.tgt2
	Get-VMHost $f.alias | get-vmhosthba -device $sw_iscsi_dev | New-IScsiHbaTarget -Address $f.tgt3
	Get-VMHost $f.alias | get-vmhosthba -device $sw_iscsi_dev | New-IScsiHbaTarget -Address $f.tgt4
}
Disconnect-VIServer -Server * -Force -confirm:$false
