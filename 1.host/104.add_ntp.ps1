# 
# Add ntp & Automatic startup at boot
#
. "$HOME/scripts/globalval.ps1"

$time1 = "time1.daumkakao.io"
$time2 = "time2.daumkakao.io"
$time3 = "time3.daumkakao.io"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	Add-VMHostNtpserver -NtpServer $time1, $time2, $time3 -vmhost $f.alias -confirm:$false
	Get-VMHost $f.alias | Get-VMHostService | Where { $_.Key -eq "ntpd"} | Set-VMHostService -Policy "on" | start-vmhostservice
}

Disconnect-VIServer -Server * -Force -confirm:$false
