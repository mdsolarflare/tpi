#Requires -Version 7.0

# Hash all files in current directory. -Parallel requires version 7 of powershell.
function FindAllDupesInCurrentDirectory {
  $hashes = Get-ChildItem -Recurse | ForEach-Object -Parallel {
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
  $duplicates | ForEach-Object { $_.Group[1..$x].Path | Remove-Item }
}

# For - later -- TODO doesn't handle dupes.
# function FlattenCurrentDirectory {
#  mv *\* . <-- this is too dangerous. need to think of something that's like reversable or something
#}

