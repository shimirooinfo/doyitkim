# 
# ESXi Host Log size change
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
#
# Scratch Folder 변경시 주석 해제
#	$syslogdslogdir = "[" + $f.datastore + "]" +" scratch/log"
#	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.global.logDir | Set-AdvancedSetting -Value $syslogdslogdir  -confirm:$false
#
	Get-AdvancedSetting -Entity (Get-VMHost -Name $f.alias) -Name Syslog.loggers.fdm.rotate |Set-AdvancedSetting -Value 20 -confirm:$false
	Get-AdvancedSetting -Entity (Get-VMHost -Name $f.alias) -Name Syslog.loggers.hostd.rotate |Set-AdvancedSetting  -Value 20 -confirm:$false
	Get-AdvancedSetting -Entity (Get-VMHost -Name $f.alias) -Name Syslog.loggers.shell.rotate |Set-AdvancedSetting -Value 20 -confirm:$false
	Get-AdvancedSetting -Entity (Get-VMHost -Name $f.alias) -Name Syslog.loggers.shell.size |Set-AdvancedSetting -Value 5120 -confirm:$false
	Get-AdvancedSetting -Entity (Get-VMHost -Name $f.alias) -Name Syslog.loggers.syslog.rotate |Set-AdvancedSetting -Value 20 -confirm:$false
	Get-AdvancedSetting -Entity (Get-VMHost -Name $f.alias) -Name Syslog.loggers.syslog.size |Set-AdvancedSetting -Value 5120 -confirm:$false
	Get-AdvancedSetting -Entity (Get-VMHost -Name $f.alias) -Name Syslog.loggers.vmkernel.rotate |Set-AdvancedSetting -Value 20 -confirm:$false
	Get-AdvancedSetting -Entity (Get-VMHost -Name $f.alias) -Name Syslog.loggers.vmkernel.size |Set-AdvancedSetting -Value 10240 -confirm:$false
	Get-AdvancedSetting -Entity (Get-VMHost -Name $f.alias) -Name Syslog.loggers.vmksummary.rotate |Set-AdvancedSetting -Value 20 -confirm:$false
	Get-AdvancedSetting -Entity (Get-VMHost -Name $f.alias) -Name Syslog.loggers.vmksummary.size |Set-AdvancedSetting -Value 10240 -confirm:$false
	Get-AdvancedSetting -Entity (Get-VMHost -Name $f.alias) -Name Syslog.loggers.vpxa.rotate |Set-AdvancedSetting -Value 20 -confirm:$false
	Get-AdvancedSetting -Entity (Get-VMHost -Name $f.alias) -Name Syslog.loggers.vpxa.size |Set-AdvancedSetting -Value 10240 -confirm:$false
}
Disconnect-VIServer -Server * -Force -confirm:$false
