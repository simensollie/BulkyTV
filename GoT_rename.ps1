
Dir | Get-ChildItem -Filter "*Game*Thrones*" Rename-Item -NewName {$_.name -replace "Game.of.Thrones.","Game of Thrones - "}

<#
	get name of every folder
	loop through every name and cut off on first nr x
	rename that folder "Season x"
	
	get child items
#>


$folder = Read-Host "Enter folder where media is stored"
$shows = Get-ChildItem $folder
foreach ($episode in $shows) {

	$newname = $episode.Name -replace '\[(\d{1}).(\d{2})\]', '- S0$1E$2 -'
	Write-Host $episode.Name" will be renamed to "$newname

	Rename-Item -literalpath $episode.FullName -NewName $newname -Force
}