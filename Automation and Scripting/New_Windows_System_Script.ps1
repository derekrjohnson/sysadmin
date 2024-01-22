# Ask for the hostname
$HostName = Read-Host -Prompt 'Input a hostname: '

# Change the hostname
Rename-Computer -NewName $HostName 

# Ask for the interface alias, IP address, subnet prefix length, and default gateway
$InterfaceAlias = Read-Host -Prompt 'Input your Interface Alias: '
$IPAddress = Read-Host -Prompt 'Input your new IP Address: '
$PrefixLength = Read-Host -Prompt 'Input your Subnet Prefix Length (bytes): '
$DefaultGateway = Read-Host -Prompt 'Input your Default Gateway: '

# Change the local IPv4 address, subnet mask, and default gateway
New-NetIPAddress -InterfaceAlias $InterfaceAlias -IPAddress $IPAddress -PrefixLength $PrefixLength -DefaultGateway $DefaultGateway 

# Set DNS
$dnsServer = 10.0.5.2
Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddress $dnsServer

# Ask for the new local admin username and password
$AdminUsername = Read-Host -Prompt 'Input new Local Admin Username: '
$AdminPassword = Read-Host -Prompt 'Input new Local Admin Password: ' -AsSecureString

# Create a new local admin user
New-LocalUser -Name $AdminUsername -Password $AdminPassword -PasswordNeverExpires $True
Add-LocalGroupMember -Group "Administrators" -Member $AdminUsername
