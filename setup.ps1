# Global Variables
$settingsFile = "C:\Users\User\Desktop\CP_Scoring_Engine\Configs\settings.json"
$settingsJSON = Get-Content $settingsFile -Raw | ConvertFrom-Json

Import-Module NetSecurity

# Setup Functions
function InstallMisc {
    Param (
        [parameter(mandatory=$true)][string]$file_folder
    )
    $file_folder = Get-ChildItem "$file_folder"
    foreach ($file in $file_folder) {
        # Invoke-Expression -Command "C:\Users\User\Desktop\CES_Scoring_Engine\Installers\$file" <- If you want to have the powershell script install exe's for you. (NOT RECOMMENDED, DUE TO LOAD TIMES)
    }
    "abcdefg02946$! - Just in case I forget, this is my account password!" | Out-File -FilePath "C:\Program Files (x86)\MonkeyDanPasswords.txt" 
}

function ForensicsSetup {
    $ForensicsOne = "C:\Users\User\Desktop\ForensicsQuestionOne.txt"
    "One of our friend's Dan has lost his password! He says he stored some pictures of his monkey family and wants to get them back before Benjamin the Hacker gets to it.`nHint: He said he left it on this user profile.`nPlease enter your answer on the line below the dashed and save the text file. If correct you will receive points.`n-----------------------------"| Out-File -FilePath $ForensicsOne
    $ForensicsTwo = "C:\Users\User\Desktop\ForensicsQuestionTwo.txt"
    "Based off of the slides that you heard today, what is the tool that allows you to browse the internet?`nPlease enter your answer on the line below the dashed and save the text file. If correct you will receive points.`n-----------------------------" | Out-File -FilePath $ForensicsTwo
}

function InstallCosmetics {
    Param (
        [string]$music,
        $scoring_site
    )
    $user_data_dir="C:\ChromeUserData"
    $chrome = (Get-Item "C:\Program Files\Google\Chrome\Application\chrome.exe").FullName
    Start-Process -FilePath $chrome -ArgumentList "--disable-web-security", "--disable-gpu", "--user-data-dir=$user_data_dir", $scoring_site -PassThru
}
function SetPolicies {
    secedit /configure /db C:\Windows\security\local.sdb /cfg $settingsJSON.policies_config_path /areas SECURITYPOLICY
}

function CreateAccs {
    Param (
        [System.Collections.ArrayList] $user_names,
        [System.Collections.ArrayList] $perm_levels,
        [System.Collections.ArrayList] $passwords
    )
    for ($i = 0; $i -lt $user_names.Count; $i++) {
        $username = $user_names[$i]
        $password = $passwords[$i]
        if ($password -eq "") {
            New-LocalUser -Name $username -PasswordNeverExpires
            Enable-LocalUser -Name $username
        } else {
            New-LocalUser -Name $username -Password (ConvertTo-SecureString $password -AsPlainText -Force)
        }
        if ($perm_levels -eq "Admin") {
            Add-LocalGroupMember -Group "Administrators" -Member $username
        }
    }
}

function firewallEdit {
    # Alternative rules you could set for the firewall.
    """
    $RDP = Get-NetFirewallRule -DisplayName Remote Desktop
    $RDP.Enabled = $true
    $inHTTP = Get-NetFirewallRule -DisplayName HTTP-Inbound
    $inHTTP.Enabled = $true
    """
    Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False
}

# Instructions
$users = New-Object -TypeName 'System.Collections.ArrayList';
$passwords = New-Object -TypeName 'System.Collections.ArrayList';
$perms = New-Object -TypeName 'System.Collections.ArrayList';

$users.Add("BenjaminTheHacker")
$passwords.Add("HackerThingz")
$perms.Add("Admin")

$GLOBAL:PROGRESS = @{}
$json = $GLOBAL:PROGRESS | ConvertTo-Json
$json | Out-File -FilePath $settingsJSON.hashtable_path

$scoringPath = $settingsJSON.scoring_file_path
New-BurntToastNotification -AppLogo $settingsJSON.logo -Text 'CP Scoring Engine', "Now setting up Virtual Machine Image", "Theme: BTD6"
InstallMisc -file_folder $settingsJSON.installer_path
InstallCosmetics -scoring_site $settingsJSON.HTML_path
SetPolicies
CreateAccs -user_names $users -passwords $passwords -perm_levels $perms
firewallEdit
ForensicsSetup

Start-Sleep -Seconds 7

Write-Host "Starting scoring..."
Invoke-Expression -Command $scoringPath