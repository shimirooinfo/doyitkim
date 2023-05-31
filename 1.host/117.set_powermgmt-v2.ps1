#
# Set default path policy
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$esxcli = Get-Esxcli -vmhost $f.alias -V2
	$TmpArgs = $esxcli.hardware.power.policy.set.CreateArgs()
	$TmpArgs.id = 1
	$esxcli.hardware.power.policy.set.invoke($TmpArgs)
}
Disconnect-VIServer -Server * -Force -confirm:$false
