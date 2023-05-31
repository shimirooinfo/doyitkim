# 
# Disable SSH Warning Message 
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	Get-AdvancedSetting -Entity (Get-VMHost -Name $f.alias) -Name UserVars.SuppressShellWarning |Set-AdvancedSetting -Value 1 -Confirm:$fals
}

Disconnect-VIServer -Server * -Force -confirm:$false
