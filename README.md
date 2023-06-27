# Welcome to the CP Scoring Engine Demo! 

This is a series of scripts and GUI's that allow you to setup your own CyberPatriot style competition images and easily configure to detect for changes and award points! 
This software was built with the intention of 

Do NOT run this on your own host machine, as it will rewrite all security policies. Currently you NEED to do manual cleanup of the image youself, but I will be adding a cleanup function soon.

This was software was created by Nathan Che. 

## Demo

https://user-images.githubusercontent.com/59159552/231617324-c48e72bb-15ce-481d-92d9-0675f95b1dbb.mp4

## Features
- Complete security policy rewrite (customizable, through policies.cfg)
- Automatic program installation (though not recommended, due to varying load times causing the scoring engine to halt)
- Themed scoring GUI hosted on local html file
- Deleted user, files, and folder detection (customizable)
- Changed security policy detection (customizable)

## Setup

Download a blank Windows virtual machine: 
Disable "Virtualize Intel VT-x/EPT or AMD-V/RVI" on the CPU is using a nested virtual machine.

Run Powershell ISE as administrator.
Run "Set-ExecutionPolicy RemoteSigned" and click "Yes to All"
Run "Install-Module -Name BurntToast -RequiredVersion 0.8.5" <- Toast Notification Manager
Install NuGet Provider if prompted and trust all "unfilted repositories" if prompted.
Navigate to local repository folder.

Install Google Chrome.
Adjust your settings.json file as you see fit (make sure paths are all set)

## Roadmap

I plan to continue developing this scoring engine for future teams to use, and it will include the following features:
- Cleanup function for image
- Firewall detection
- Full policy checks (audits, etc.)
- Netstat logs
- Registry changes