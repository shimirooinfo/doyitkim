#
# Name of the scripts
#
# D80에 적용하지 않음 
#
# target 파일을 매개변수로 받을때 아래 주석 해제
#
#Param(
#        [Parameter(Mandatory=$True,Position=1)]
#        [string]$targetfile
#)
# target 파일을 매개변수로 받을때 아래 주석 처리

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip
	get-vmhost $f.alias |Get-VMHostFirewallException | Where {$_.Name -eq "syslog"} | Set-VMHostFirewallException -Enabled $true -Confirm:$false
}
Disconnect-VIServer -Server * -Force -confirm:$false
