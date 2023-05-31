#
# HBA Rescan
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	get-vmhoststorage -VMhost $f.alias -rescanallhba
}
Disconnect-VIServer -Server * -Force -confirm:$false
