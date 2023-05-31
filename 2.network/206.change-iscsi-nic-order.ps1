#
# Change vSwitch Teaming Policy 
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
	echo $f.alias
	get-vmhost $f.alias | Get-VirtualPortgroup -Name "service-for-iscsi1" | Get-NicTeamingPolicy | Set-NicTeamingPolicy  -MakeNICUnused vmnic5 -MakeNICActive vmnic4
	get-vmhost $f.alias | Get-VirtualPortgroup -Name "service-for-iscsi2" | Get-NicTeamingPolicy | Set-NicTeamingPolicy  -MakeNICUnused vmnic4 -MakeNICActive vmnic5

}
Disconnect-VIServer -Server * -Force -confirm:$false
