#
# Bind iscsi kernel 
#
# target 파일을 매개변수로 받을때 아래 주석 해제
#
#Param(
#        [Parameter(Mandatory=$True,Position=1)]
#        [string]$targetfile
#)
# target 파일을 매개변수로 받을때 아래 주석 처리

. "$HOME/scripts/globalval.ps1"

$sw_iscsi = "vmhba64"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$esxcli = Get-Esxcli -vmhost $f.alias
	$esxcli.iscsi.networkportal.add($sw_iscsi,$true,"vmk2")
	$esxcli.iscsi.networkportal.add($sw_iscsi,$true,"vmk3")
}
Disconnect-VIServer -Server * -Force -confirm:$false
