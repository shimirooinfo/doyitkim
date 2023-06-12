# 
# Add ntp & Automatic startup at boot
#
. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	Add-VMHostNtpserver -NtpServer $time1, $time2, $time3 -vmhost $f.alias -confirm:$false
	Get-VMHost $f.alias | Get-VMHostService | Where { $_.Key -eq "ntpd"} | Set-VMHostService -Policy "on" | start-vmhostservice
}

Disconnect-VIServer -Server * -Force -confirm:$false
