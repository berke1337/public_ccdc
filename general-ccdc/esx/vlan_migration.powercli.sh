# Script to tag all VM's
# Author: Vania Smirnov, with Berkeley CCDC

# Possible issues:
# 1. if last octet is not 3 digits, code will fail
# 2. if ip is null, we get errors, and a vlan_id is reused
# 3. this script assumes we are on vswitch0. this may not always be the case
#############################################################
# install powercli and paste in this script
#https://my.vmware.com/group/vmware/get-download?downloadGroup=VSPS510-PCLI-510R2
# note - all commands are case insensitive

$MyESXiHostIP="10.42.43.205" # CHANGE THIS

# allow remote scripting - otherwise powercli will not work
Set-ExecutionPolicy RemoteSigned

## connect to server
Connect-VIServer $MyESXiHostIP -username admin

## optional password change
#Set-VMHostAccount -UserAccount root -password MyPa$$!



## 0. recon (optional) ##
#get-vm # lists all VN's, with name, PowerSate, and details
#get-VirtualSwitch # list virtual switches. in all honesty the GUI is probably easier to look at

# 1. for each vm , create a vlan with name same as (VM | VLAN_ID) and ID same as last 3 digits of IP
$VM_LIST = get-vm # populate list
$VLAN_ID = 201 # start from 200
foreach ($VM in $VM_LIST) {
    # get last three digits of ip, assign to VLAN_ID
    #$IP=$VM.guest.ipaddress
    #$VLAN_ID =  $IP[0].substring($IP[0].length -3, 3)

	# get name
    $VM_NAME = $VM.name
	$VLAN_NAME = $VM.name + " - " + $VLAN_ID
    # create new vlan with VM_NAME and VLAN_ID
    Get-VirtualSwitch -name vSwitch0 | new-VirtualPortGroup -name $VM_NAME -vlanid $VLAN_ID
    # move VM to new VLAN
    Get-VM $VM_NAME | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName $VLAN_NAME

	#increment vlan counter
	$VLAN_ID = $VLAN_ID + 1
}



### move all vm's back to default
$VM_LIST = get-vm # populate list
foreach ($VM in $VM_LIST) {
	# get name
    $VM_NAME = $VM.name
	# move VM to new VLAN
    Get-VM $VM_NAME | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName "VM Network"
}







