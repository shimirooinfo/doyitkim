#
# Set a path selection policy
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
	#get-vmhost $f.ip |Get-ScsiLun -LunType disk | Where-Object {$_.Model -eq "MD38xxi"} | Set-ScsiLun -MultipathPolicy "RoundRobin"
	get-vmhost $f.alias |Get-ScsiLun -LunType disk | Where-Object {$_.Canonicalname -like "naa.600*"} | Set-ScsiLun -MultipathPolicy "RoundRobin"
}
Disconnect-VIServer -Server * -Force -confirm:$false
