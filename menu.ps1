function Show-Menu
{
     param (
           [string]$Title = ‘VMware ESXi Configuration Scripts ’
     )
     cls
     Write-Host "================ $Title ================"
    
     Write-Host "1: Add Host"
     Write-Host "2: Add NTP"
     Write-Host "3: Add Domain Name"
     Write-Host "4: Start SSH Service"
     Write-Host "5: Disable SSH Warning Message"
     Write-Host "6: Setup Syslog"
     Write-Host "6: Setup Logsize"
     Write-Host "6: Rename Local Datastore"
     Write-Host "6: Setup Power Management"
     Write-Host “Q: Press ‘Q’ to quit.”
}

do
{
     Show-Menu
     $input = Read-Host “Please make a selection”
     switch ($input)
     {
           ‘1’ {
                cls
                ‘You chose option #1’
           } ‘2’ {
                cls
                ‘You chose option #2’
           } ‘3’ {
                cls
                ‘You chose option #3’
           } ‘q’ {
                return
           }
     }
     pause
}
until ($input -eq ‘q’)
