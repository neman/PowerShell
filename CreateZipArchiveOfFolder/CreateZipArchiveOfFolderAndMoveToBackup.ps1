# Idea from http://blogs.technet.com/b/heyscriptingguy/archive/2015/03/09/use-powershell-to-create-zip-archive-of-folder.aspx
if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
$applicationFolder = $PSScriptRoot
$applicationFolder
$backupFolder = "D:\Dropbox\DevBox\PowerShell\TestFiles\Backup\"
$currentDate = (Get-Date).ToString("yyyyMMdd")
$backupDestination = $backupFolder + $currentDate
$name =  Split-Path $applicationFolder -Leaf

#Create Backup folder name with current date if does not exist
#TODO:Create function for this
if (!(Test-Path $backupDestination)) 
{
   New-Item $backupDestination -type directory
}

Add-Type -assembly System.IO.Compression.Filesystem
#[io.compression.zipfile]::CreateFromDirectory($applicationFolder, $backupDestination + "\test.zip") 
[IO.Compression.Zipfile]::CreateFromDirectory($applicationFolder, $backupDestination + "\" + $name + "_" + 
(Get-Date).TimeOfDay.Hours.ToString() + (Get-Date).TimeOfDay.Minutes.ToString() + ".zip"
     ,[System.IO.Compression.CompressionLevel]::Optimal,[System.Convert]::ToBoolean("False")) 
     

     