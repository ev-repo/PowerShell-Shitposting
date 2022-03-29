<#
Name: Share-Calendar.ps1
Version 1.0
Description: Provides a user access to 1+ user's calendar folder on Exchange
Author: Evan Berkowitz
Date: 03/28/2022

THIS MUST EITHER BE RAN THROUGH EXCHANGE SHELL OR AFTER REMOTELY CONNECTING TO EXCHANGE POWERSHELL
#>

#Initializes variables for later fun
$oneMore = "y"
$mailboxes = @()
$accessor = Read-Host -Prompt "Enter the username of who will be accessing the calendar"

#Allows user to change permissions for multiple mailboxes
while ($oneMore -eq "y"){
	$mailboxes = $mailboxes += Read-Host -Prompt "Enter the username of who's calendar you would like to share"
	$oneMore = Read-Host -Prompt "Would you like to share another mailbox? (y/n)"
}

#Gives the permissions for each mailbox provided
foreach ($mailbox in $mailboxes){
	Add-MailboxFolderPermission ${mailbox}:\calendar -User $accessor -AccessRights Editor
}