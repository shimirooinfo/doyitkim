#
# Get NIC Duplex Information
#
Param(
        [Parameter(Mandatory=$True,Position=1)]
        [string]$targetfile
)

$VcInfoFile = "../0.target/vc_iroo.csv"


# Connect to the vCenter Server
foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
	Write-host "Connecting to vCenter Server: " -ForegroundColor Green -NoNewline; Write-Host $VcInfo.vc -ForegroundColor Yellow
        Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}

foreach ($f in (import-csv -path $targetfile))
{
 	echo $f.alias 
	echo "############################################" 
	$esxcli = Get-EsxCli -VMHost $f.alias
	$esxcli.network.nic.list() |select Name, Speed, Duplex, Link
}
Disconnect-VIServer -Server * -Force -confirm:$false
