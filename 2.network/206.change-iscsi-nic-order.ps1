#
# Change vSwitch Teaming Policy 
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	get-vmhost $f.alias | Get-VirtualPortgroup -Name "service-for-iscsi1" | Get-NicTeamingPolicy | Set-NicTeamingPolicy  -MakeNICUnused vmnic5 -MakeNICActive vmnic4
	get-vmhost $f.alias | Get-VirtualPortgroup -Name "service-for-iscsi2" | Get-NicTeamingPolicy | Set-NicTeamingPolicy  -MakeNICUnused vmnic4 -MakeNICActive vmnic5

}
Disconnect-VIServer -Server * -Force -confirm:$false
