# Hash all files in current directory
function FindAllDupesInCurrentDirectory {
  $hashes = Get-ChildItem -Recurse | ForEach-Object {
    Get-FileHash -Path $_.FullName -Algorithm SHA256
  }
  return $hashes
}

# Group similar hashes
function GroupHashes($hashes) {
  $duplicates = $hashes | Group-Object -Property Hash | Where-Object { $_.Count -gt 1 }
  return $duplicates
}

# Delete first 100 dupes
function DeleteFirstXDupes($x, $duplicates) {
  $duplicates | ForEach-Object { $_.Group[1..100].Path | Remove-Item }
}