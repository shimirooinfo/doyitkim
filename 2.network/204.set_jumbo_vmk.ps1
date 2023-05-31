#
# set jubmo frame for iscsi vmk
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
	$esxcli = Get-Esxcli -vmhost $f.alias
	$esxcli.network.ip.interface.set("true", "vmk2", "9000")
	$esxcli.network.ip.interface.set("true", "vmk3", "9000")
	$esxcli.network.vswitch.standard.set("listen", "9000", "vSwitch1")
}
Disconnect-VIServer -Server * -Force -confirm:$false
