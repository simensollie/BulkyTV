# Store all the start up variables so you can clean up when the script finishes.
if ($startupvariables) { 
	try {
		Remove-Variable -Name startupvariables  -Scope Global -ErrorAction SilentlyContinue 
	} catch { } 
}
New-Variable -force -name startupVariables -value ( Get-Variable | ForEach-Object { $_.Name } )
##################################################################################################

$seasons = Get-ChildItem "Season*"
rmdir $seasons

##################################################################################################
Function Clean-Memory {
	Get-Variable | Where-Object { $startupVariables -notcontains $_.Name } | ForEach-Object {
		try { 
			Remove-Variable -Name "$($_.Name)" -Force -Scope "global" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue 
		} catch { }
	}
}