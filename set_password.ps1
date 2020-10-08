$targetroot = "https://[your instance].azurewebsites.net"
$username = "elastic"
$bootstrapPass = "[your pass]"
$newPass = "[new password]"

$secpasswd = ConvertTo-SecureString $bootstrapPass -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $secpasswd)

$result = Invoke-RestMethod "$targetroot/_security/user/_password" -Method POST -Credential $credential -Body "{`"password`" : `"$newPass`"}" -ContentType "application/json"