## Get all dupes
$Table = Get-ChildItem -Recurse -File `
| Group-Object -Property Length `
| ?{ $_.Count -gt 1 } `
| %{ $_.Group } `
| Get-FileHash `
| Group-Object -Property Hash `
| ?{ $_.Count -gt 1 } `
| %{ $_.Group }

## make hashtables
$myHashtable = @{}
## delete dupes
foreach($item in $Table) { 
    if ($myHashtable.ContainsKey($item.Hash)) {
        Write-Host "Removing Dupe @ " $item.Path
        Remove-Item -Force $item.Path
        Write-Host "Original @      " $myHashTable[$item.Hash]
    } else {
        $myHashTable[$item.Hash] = $item.Path
    }
}
