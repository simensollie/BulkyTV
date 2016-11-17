# Store all the start up variables so you can clean up when the script finishes.
if ($startupvariables) { 
	try {
		Remove-Variable -Name startupvariables  -Scope Global -ErrorAction SilentlyContinue 
	} catch { } 
}
New-Variable -force -name startupVariables -value ( Get-Variable | ForEach-Object { $_.Name } )
##################################################################################################

$SHOWPATH = "c:\users\simen\powershell script testing\Game of Thrones"
$PATH = [System.IO.Path];
$SHOWNAME = $PATH::GetFileName($PATH::GetDirectoryName($SHOWPATH+"\file.txt"))

function Create-Seasons {
	param([int]$x)
	$wrongname = $SHOWNAME.replace(' ', '.')
	for ($i = 1; $i -le $x; $i++){
		New-item -itemType dir -path $SHOWPATH -name "$wrongname.Season.$i.720p.bleefyprod"
	}
}

function Remove-Seasons {
	$show = Get-ChildItem -path $SHOWPATH -filter '*Season*'
	foreach ($season in $show){
		Remove-Item -r -path $show.FullName
	}
}

function Create-Episodes {
	param([int]$y)
	$show = Get-ChildItem -path $SHOWPATH -dir
	
	foreach ($season in $show){
		$char = [char[]]$season.FullName
		[string]$x = ""
		for ($i = 0; $i -lt $char.length; $i++){
			if ($char[$i] -match "[0-9]"){
				[string]$x = [string]$char[$i]
				if ($char[$i+1] -match "[0-9]"){
					[string]$x += [string]$char[$i+1]
				}
				break
			}
		}
		[int]$j = [int]$x
		
		for ($i = 1; $i -le $y; $i++){
			$xgt9 = -join("Game.of.Thrones.S$x","E0$i.720p.bleefyprod.mp4")
			$ygt9 = -join("Game.of.Thrones.S0$x","E$i.720p.bleefyprod.avi")
			$xygt9 = -join("Game.of.Thrones.S$x","E$i.720p.bleefyprod")
			$xylt9 = -join("Game.of.Thrones.S0$x","E0$i.720p.bleefyprod.mkv")
		
			if ($x -gt 9){
				new-item -type file -path $season.FullName -name $xgt9
			} elseif ($i -gt 9){
				new-item -type file -path $season.FullName -name $ygt9
			} elseif ($x -gt 9 -and $i -gt 9){
				new-item -type file -path $season.FullName -name $xygt9
			} else {
				new-item -type file -path $season.FullName -name $xylt9
			}
		}
	}
}

function Remove-Episodes {
	$season = Get-ChildItem -path $SHOWPATH -file -r | Where-Object {
		$_.Extension -eq ".mkv" -or $_.Extension -eq ".avi" -or $_.Extension -eq ".mp4"}
	
	foreach ($episode in $season){
		remove-item -path $episode.FullName
	}
}

<# Remove hash to initiate function #>
#Create-Seasons -x 10
#Remove-Seasons
Create-Episodes -y 12
#Remove-Episodes


##################################################################################################
Function Clean-Memory {
	Get-Variable | Where-Object { $startupVariables -notcontains $_.Name } | ForEach-Object {
		try { 
			Remove-Variable -Name "$($_.Name)" -Force -Scope "global" 
				-ErrorAction SilentlyContinue -WarningAction SilentlyContinue 
		} catch { }
	}
}