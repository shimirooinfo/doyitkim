#
# Copy Local Client File to DataStore
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip 
	#
	$PatchFile=$f.path+$f.FileName
	$Storepath="vmstore:\test\"+$f.datastore+"\"
	Copy-DatastoreItem -Item $PatchFile -Destination $Storepath
	echo $f.ip	
}
Disconnect-VIServer -Server * -Force -confirm:$false
