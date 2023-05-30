function Show-Menu
{
     param (
           [string]$Title = ‘VMware ESXi Configuration Scripts ’
     )
     cls
     Write-Host "============================================="
     Write-Host "     $Title"
     Write-Host " "
     Write-Host "                Version: 1.0"
     Write-Host "            Written by Yanghwa Kim"
     Write-Host "              yhkim@iroo.co.kr"
     Write-Host "============================================="
     Write-Host "     >>>>>>>>>> Config Host <<<<<<<<<<"
     Write-Host "============================================="
     Write-Host "1: Create Cluster"
     Write-Host "1: 클러스터 생성하기"
     Write-Host "2: Delete Cluster"
     Write-Host "3: Add Host"
     Write-Host "4: Add NTP"
     Write-Host "5: Add Domain Name"
     Write-Host "6: Setup Syslog"
     Write-Host "7: Setup Logsize"
     Write-Host "8: Setup Power Management"
     Write-Host "9: Start SSH Service"
     Write-Host "10: Disable SSH Warning Message"
     Write-Host "============================================="
     Write-Host "     >>>>>>>>>> Config Network <<<<<<<<<<"
     Write-Host "============================================="
     Write-Host "21: Add vSwitch"
     Write-Host "22: Change LB Policy"
     Write-Host "23: Set Jumbo Frame"
     Write-Host "24: Change iSCSI Nic Order"
     Write-Host "============================================="
     Write-Host "     >>>>>>>>>> Config Storage <<<<<<<<<<"
     Write-Host "============================================="
     Write-Host "31: Rename Local Datastore"
     Write-Host "32: Enable iSCSI Initiator"
     Write-Host "33: Add iSCSI Target"
     Write-Host "34: Bind iSCSI Kernel"
     Write-Host "35: Set Path policy"
     Write-Host "36: Set Default Path policy"
     Write-Host "============================================="
     Write-Host "      >>>>>>>>>> Operation <<<<<<<<<<"
     Write-Host "============================================="
     Write-Host "41: Host Enter Maintenance Mode"
     Write-Host "42: Host Exit Maintenance Mode"
     Write-Host "43: Host Reboot"

     Write-Host “Q: Quit.”
}

do
{
     Show-Menu
     $input = Read-Host “Please make a selection”
     switch ($input)
     {
           ‘1’ {
                cls
                invoke-expression -Command $PSScriptRoot/4.cluster/100.new_cluster.ps1
           } ‘2’ {
                cls
                invoke-expression -Command $PSScriptRoot/4.cluster/101.del_cluster.ps1
           } ‘3’ {
                cls
                invoke-expression -Command $PSScriptRoot/1.host/103.add_host.ps1
           } ‘4’ {
                cls
                invoke-expression -Command $PSScriptRoot/1.host/104.add_ntp.ps1
           } ‘5’ {
                cls
                invoke-expression -Command $PSScriptRoot/1.host/106.add_domain_name.ps1
           } ‘6’ {
                cls
                invoke-expression -Command $PSScriptRoot/1.host/112.setup_syslog.ps1
           } ‘7’ {
                cls
                invoke-expression -Command $PSScriptRoot/1.host/115.setup_log_size.ps1
           } ‘8’ {
                cls
                invoke-expression -Command $PSScriptRoot/1.host/117.set_powermgmt-v2.ps1
           } ‘9’ {
                cls
                invoke-expression -Command $PSScriptRoot/1.host/108.start_ssh_service.ps1
           } ‘10’ {
                cls
                invoke-expression -Command $PSScriptRoot/1.host/110.disable_ssh_warning_message.ps1
           } ‘21’ {
                cls
                invoke-expression -Command $PSScriptRoot/2.network/201.add_vswitch_VLAN.ps1
           } ‘22’ {
                cls
                invoke-expression -Command $PSScriptRoot/2.network/202.change-lb-policy.ps1
           } ‘23’ {
                cls
                invoke-expression -Command $PSScriptRoot/2.network/204.set_jumbo_vmk.ps1
           } ‘24’ {
                cls
                invoke-expression -Command $PSScriptRoot/2.network/206.change-iscsi-nic-order.ps1
           } ‘31’ {
                cls
                invoke-expression -Command $PSScriptRoot/3.storage/314.rename_local_datastore.ps1
           } ‘32’ {
                cls
                invoke-expression -Command $PSScriptRoot/3.storage/302.enable_sw_iscsi.ps1
           } ‘33’ {
                cls
                invoke-expression -Command $PSScriptRoot/3.storage/303.add_iscsi_target.ps1
           } ‘34’ {
                cls
                invoke-expression -Command $PSScriptRoot/3.storage/306.bind_iscsi_kernel.ps1
           } ‘35’ {
                cls
                invoke-expression -Command $PSScriptRoot/3.storage/308.set-path-policy.ps1
           } ‘36’ {
                cls
                invoke-expression -Command $PSScriptRoot/3.storage/310.set_default_path_policy-v2.ps1
           } ‘41’ {
                cls
                invoke-expression -Command $PSScriptRoot/1.host/999.host-enter_maintenance_mode.ps1
           } ‘42’ {
                cls
                invoke-expression -Command $PSScriptRoot/1.host/999.host-exit_maintenance_mode.ps1
           } ‘43’ {
                cls
                invoke-expression -Command $PSScriptRoot/1.host/997.host_rebooting.ps1
           } ‘q’ {
                return
           }
     }
     pause
}
until ($input -eq ‘q’)
