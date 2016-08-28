# Store all the start up variables so you can clean up when the script finishes.
if ($startupvariables) { 
	try {
		Remove-Variable -Name startupvariables  -Scope Global -ErrorAction SilentlyContinue 
	} catch { } 
}
New-Variable -force -name startupVariables -value ( Get-Variable | ForEach-Object { $_.Name } ) 
##################################################################################################

$sesons = Get-ChildItem -Directory
$nrOfSeasons = $seasons.length
$nrOfEpisodes = 10

for ($i = 1; $i -le $nrOfSeasons; $i++){
	for ($j = 1; $j -le $nrOfEpisodes; $j++){
	
		$seasonsGreaterThan9 = -join("Game.of.Thrones.S$i","E0$j.720p.bleefyprod")
		$episodesGreaterThan9 = -join("Game.of.Thrones.S0$i","E$j.720p.bleefyprod")
		$epAndSeasGreaterThan9 = -join("Game.of.Thrones.S$i","E$j.720p.bleefyprod")
		$epAndSeasLessThan9 = -join("Game.of.Thrones.S0$i","E0$j.720p.bleefyprod")
	
		if ($i -gt 9){
			new-item -type file -path ".\Season $i" -name $seasonsGreaterThan9
		} elseif ($j -gt 9){
			new-item -type file -path ".\Season 0$i" -name $episodesGreaterThan9
		} elseif ($i -gt 9 -and $j -gt 9){
			new-item -type file -path ".\Season $i" -name $epAndSeasGreaterThan9
		} else {
			new-item -type file -path ".\Season 0$i" -name $epAndSeasLessThan9
		}
	}
}

##################################################################################################
Function Clean-Memory {
	Get-Variable | Where-Object { $startupVariables -notcontains $_.Name } | ForEach-Object {
		try { 
			Remove-Variable -Name "$($_.Name)" -Force -Scope "global" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue 
		} catch { }
	}
}