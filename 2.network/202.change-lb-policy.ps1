#
# Change vSwitch Teaming Policy 
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$policy = get-vmhost $f.alias| Get-VirtualSwitch -Name vSwitch1 | Get-NicTeamingPolicy
	$policy | Set-NicTeamingPolicy -LoadBalancingPolicy LoadBalanceIP
}
Disconnect-VIServer -Server * -Force -confirm:$false
