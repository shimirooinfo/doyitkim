#
# esxcli software vib list 
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$StorageFile=$f.path+$f.FileName
	$esxcli = Get-Esxcli -vmhost $f.alias -v2
	$esxcli.software.vib.list.invoke() | where {$_.ID -like "*tools*")
}
Disconnect-VIServer -Server * -Force -confirm:$false
