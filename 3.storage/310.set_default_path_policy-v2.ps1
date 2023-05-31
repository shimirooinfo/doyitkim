#
# Set default path policy
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
	$esxcli = Get-Esxcli -vmhost $f.alias -V2
	$TmpArgs = $esxcli.storage.nmp.satp.set.CreateArgs()
	$TmpArgs.satp = "VMW_SATP_ALUA"
	$TmpArgs.defaultpsp ="VMW_PSP_RR" 
	$TmpArgs.boot = "$true"
	$esxcli.storage.nmp.satp.set.invoke($TmpArgs)
}
Disconnect-VIServer -Server * -Force -confirm:$false
