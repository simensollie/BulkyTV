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
$PATH = [System.IO.Path];
$SHOWNAME = $path::GetFileName($PATH::GetDirectoryName($SHOWPATH+"\file.txt"))
$FILEFORMAT = '.mkv', '.avi', '.mp4'

<# Rename season folders #>
function Rename-Seasons {
	# Gets list of folders/seasons and iterates through.
	# Cast folder name to char[] and then iterate through to find 
	# season number. If folder name is not equal to correct naming,
	# renames folder.
	$show = Get-ChildItem -dir -path $SHOWPATH
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
#avi, mkv, mp4
function Rename-Episodes {
	$season = Get-ChildItem -file -path $SHOWPATH 
	Get-ChildItem -file -r -path '.\Game of Thrones\' 
		| Where-Object {$_.Extension -eq ".720p" -or $_.Extension -eq ".bleefyprod"}
}


<# Calling functions #>

Rename-Seasons

write-output "Name of show: $SHOWNAME"



##################################################################################################
function Clean-Memory {
	Get-Variable | Where-Object { $startupVariables -notcontains $_.Name } | ForEach-Object {
		try { 
			Remove-Variable -Name "$($_.Name)" -Force -Scope "global" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue 
		} catch { }
	}
}