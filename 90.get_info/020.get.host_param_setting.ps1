# 
# Add ntp & Automatic startup at boot
#
$VcInfoFile = "../0.target/vcenter_vc70.csv"
$TgtFile = "../0.target/tgt_s80_all.csv"
$OutputFile ="../99.output/info-host-param.txt"
#
$domainname = "virt.daumkakao.io"
$dnsserver = "10.20.30.40"


$testpath = test-path $OutputFile
if ($testpath)
{
	remove-item $OutputFile
}

# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
foreach ($v in (import-csv -path $vcinfofile))
{
	Connect-VIServer -Server $v.vc -user $v.user -password $v.passwd -Protocol https
}

foreach ($f in (import-csv -path $TgtFile))
{
	echo "############################################" >> $OutputFile 
 	echo $f.alias >> $OutputFile 
	echo "############################################" >> $OutputFile 
	Get-VMHostNtpserver -vmhost $f.alias  >> $OutputFile
	Get-VMHost $f.alias | Get-VMHostService | Where { $_.Key -eq "ntpd"} >> $OutputFile
	Get-VmHostNetwork -Host $f.alias >> $OutputFile
	get-vmhost $f.alias |Get-VMHostService | Where {$_.Key -eq "TSM-SSH"} >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting UserVars.SuppressShellWarning  >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.global.loghost >> $OutputFile
	get-vmhost $f.alias |Get-VMHostFirewallException | Where {$_.Name -eq "syslog"}  >> $OutputFile
	$syslogdslogdir = "[" + $f.datastore + "]" +" scratch/log"
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.global.logDir >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.loggers.fdm.rotate  >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.loggers.hostd.rotate >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.loggers.shell.rotate  >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.loggers.shell.size >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.loggers.syslog.rotate >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.loggers.syslog.size >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.loggers.vmkernel.rotate >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.loggers.vmkernel.size >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.loggers.vmksummary.rotate >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.loggers.vmksummary.size >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.loggers.vpxa.rotate >> $OutputFile
	Get-VMHost $f.alias | Get-AdvancedSetting Syslog.loggers.vpxa.size >> $OutputFile
	get-vmhost $f.alias |get-datastore |where-object {$_.Name -like "datastore*"} >> $OutputFile
}
Disconnect-VIServer -Server * -Force -confirm:$false
