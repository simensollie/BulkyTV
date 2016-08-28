# Store all the start up variables so you can clean up when the script finishes.
if ($startupvariables) { 
	try {
		Remove-Variable -Name startupvariables  -Scope Global -ErrorAction SilentlyContinue 
	} catch { } 
}
New-Variable -force -name startupVariables -value ( Get-Variable | ForEach-Object { $_.Name } )
##################################################################################################
<#
Split-Path (Split-Path c:\dir1\dir2\dir3\file.txt -Parent) -Leaf
#Output: dir3
([uri]"c:\dir1\dir2\dir3\file.txt").segments[-2].trim('/')
#Output: dir3 
#>

<# Find name of the show #>
$showDirectory = "c:\users\simen\powershell script testing\Game of Thrones"
$path = [System.IO.Path];
$show = $path::GetFileName($path::GetDirectoryName($showDirectory+"\file.txt"))

<# Rename season folders #>
$season = Get-ChildItem -dir




##################################################################################################
Function Clean-Memory {
	Get-Variable | Where-Object { $startupVariables -notcontains $_.Name } | ForEach-Object {
		try { 
			Remove-Variable -Name "$($_.Name)" -Force -Scope "global" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue 
		} catch { }
	}
}