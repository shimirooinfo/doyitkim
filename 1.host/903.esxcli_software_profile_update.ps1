#
# add host to vcenter
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
	echo $f.ip
	$esxcli = Get-Esxcli -vmhost $f.ip -v2
	$arguments = $esxcli.software.profile.update.CreateArgs()
	$arguments.depot = $f.path+$f.FileName
	$arguments.profile = “DEL-ESXi-702_17867351-A05”
	$esxcli.software.profile.update.Invoke($arguments)
}
Disconnect-VIServer -Server * -Force -confirm:$false
