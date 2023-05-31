#
# esxcli software update
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$StorageFile=$f.path+$f.FileName
	$esxcli = Get-Esxcli -vmhost $f.alias -v2
	$esxcli.software.vib.update($StorageFile,$false,$true,$true,$true,$false,$null,$null,$null)
}
Disconnect-VIServer -Server * -Force -confirm:$false
