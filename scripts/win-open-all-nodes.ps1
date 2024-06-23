# Script for quickly setting up windows terminal and ssh-ing into all nodes

# terminal profile i want to use to launch ssh
$distribution = "Ubuntu 22.04.3 LTS"

# the 4 tab ips i want to target, change per network setup
$user = "defaultUser" # this could be root, dietpi, username, etc
$ips = @("10.0.0.1", "10.0.0.2", "10.0.0.3", "10.0.0.4")

$ips | ForEach-Object -Process { wt --window 0 -p "$distribution" ssh $user@$_ }

