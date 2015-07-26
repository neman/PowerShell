# Idea from http://blogs.technet.com/b/heyscriptingguy/archive/2015/03/09/use-powershell-to-create-zip-archive-of-folder.aspx


if(!$PSScriptRoot)
{
     #For Powershell v2.0 which does not support $PSScriptRoot introduced with v3.0
     $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}
$SourceFolder = $PSScriptRoot
$SourceFolderName =  Split-Path $SourceFolder -Leaf

#The example in this script is just for the testing purpose, you should use real backup location
#e.g. $BackupFolder = "c:\Backup"
$BackupFolder = (Get-Item $SourceFolder).Parent.FullName + "\Backup\"
$CurrentDate = (Get-Date).ToString("yyyyMMdd")
#e.g. "C:\Backup\20150501"
$BackupDestinationFolder = $BackupFolder + $CurrentDate


#Create Backup destination folder if it does not exist
#TODO:Create function for this
if (!(Test-Path $BackupDestinationFolder)) 
{
   New-Item $BackupDestinationFolder -type directory
}

Add-Type -assembly System.IO.Compression.Filesystem
#[io.compression.zipfile]::CreateFromDirectory($myCurrentFolderPath, $BackupDestinationFolder + "\test.zip") 
[IO.Compression.Zipfile]::CreateFromDirectory($SourceFolder, $BackupDestinationFolder + "\" + $SourceFolderName + "_" + 
(Get-Date).TimeOfDay.Hours.ToString() + (Get-Date).TimeOfDay.Minutes.ToString() + ".zip"
     ,[System.IO.Compression.CompressionLevel]::Optimal,[System.Convert]::ToBoolean("False")) 
     

     