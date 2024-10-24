# Hash all files in current directory
$hashes = Get-ChildItem -Recurse | ForEach-Object {
  Get-FileHash -Path $_.FullName -Algorithm SHA256
}

# Group similar hashes
$duplicates = $hashes | Group-Object -Property Hash | Where-Object { $_.Count -gt 1 }

# Delete first 100 dupes
$duplicates | ForEach-Object { $_.Group[1..100].Path | Remove-Item }
