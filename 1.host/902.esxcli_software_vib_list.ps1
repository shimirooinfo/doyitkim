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
	echo $f.alias
	$StorageFile=$f.path+$f.FileName
	$esxcli = Get-Esxcli -vmhost $f.alias -v2
	$esxcli.software.vib.list.invoke() | where {$_.ID -like "*tools*")
}
Disconnect-VIServer -Server * -Force -confirm:$false
