#
# Rename Local Datastore
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
	get-vmhost $f.alias |get-datastore |where-object {$_.Name -like "datastore*"} |Set-Datastore -Name  $f.datastore
}
Disconnect-VIServer -Server * -Force -confirm:$false
