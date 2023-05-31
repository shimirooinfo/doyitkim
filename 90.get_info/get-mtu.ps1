#
# ESXi Virtual Switch MTU
#
# target ¿¿¿ ¿¿¿¿¿ ¿¿¿ ¿¿ ¿¿ ¿¿
#
#Param(
#        [Parameter(Mandatory=$True,Position=1)]
#        [string]$targetfile
#)
# target ¿¿¿ ¿¿¿¿¿ ¿¿¿ ¿¿ ¿¿ ¿¿
$TgtFile = "../0.target/tgt_d80_all.csv"

#$VcInfoFile = "../0.target/vc_iroo.csv"
$VcInfoFile = "../0.target/vc_kko_vc70.csv"

$outputfile ="C:\scripts.v5\00_output\info-mtu.txt"
foreach ($f in (import-csv -path $targetfile))
{
	echo "############################################" >> $outputfile 
 	echo $f.alias >> $outputfile 
	echo "############################################" >> $outputfile 
 	get-vmhost $f.alias | Get-VMHostNetworkAdapter -vmkernel | fl -property Mtu, PortGroupName, VMHost, IP, vMotionEnabled >> $outputfile
}
Disconnect-VIServer -Server * -Force -confirm:$false
