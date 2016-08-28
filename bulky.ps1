# Store all the start up variables so you can clean up when the script finishes.
if ($startupVariables) { 
	try {
		Remove-Variable -Name startupVariables  -Scope Global -ErrorAction SilentlyContinue 
	} catch { } 
}
New-Variable -force -name startupVariables -value ( Get-Variable | ForEach-Object { $_.Name } )
##################################################################################################

$SHOWPATH = "c:\users\simen\powershell script testing\Game of Thrones"

<# Find name of the show #>
function Get-ShowName {
	param([string]$directoryPath)
	$path = [System.IO.Path];
	$SHOW = $path::GetFileName($path::GetDirectoryName($directoryPath+"\file.txt"))
}

<# Rename season folders #>
function Rename-Seasons {
	$show = Get-ChildItem -dir -path $showDirectory
	foreach ($season in $show){
		$char = [char[]]$season.FullName
		[string]$x = ""
		for ($i = 0; $i -lt $char.length; $i++){
			if ($char[$i] -match "[0-9]"){
				# rename folder to "Season $i"
				[string]$x = [string]$char[$i]
				if ($char[$i+1] -match "[0-9]"){
					[string]$x += [string]$char[$i+1]
				}
				break
			}
		}
	
		if ($season.Name -ne "Season $x"){
			Rename-Item -literalpath $season.FullName -newName "Season $x"
		}
	}
}

<# Rename episodes #>



<# Calling functions #>
Get-ShowName -$SHOWPATH
Rename-Seasons

#write-output $SHOW


##################################################################################################
function Clean-Memory {
	Get-Variable | Where-Object { $startupVariables -notcontains $_.Name } | ForEach-Object {
		try { 
			Remove-Variable -Name "$($_.Name)" -Force -Scope "global" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue 
		} catch { }
	}
}