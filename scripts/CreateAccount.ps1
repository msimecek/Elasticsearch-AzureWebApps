$webAppName = $args[0]
$elasticPassword = $args[1]
$keyVaultName = $args[2]

$username = $args[3]
$fullName = $args[4]
$email = $args[5]
$role = $args[6]

# Generate password
Write-Host "Generating password..."
Add-Type -AssemblyName 'System.Web'
$generatedPassword = [System.Web.Security.Membership]::GeneratePassword(8, 3)

$targetroot = "https://$($webAppName).azurewebsites.net"
$elastic_username = "elastic"
$elastic_pass = "$($elasticPassword)"

## User to be created.
$new_username = $username
$new_password = $generatedPassword
$new_fullname = $fullName
$new_email = $email
$new_role = $role
## -----------

$secpasswd = ConvertTo-SecureString $elastic_pass -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($elastic_username, $secpasswd)

Write-Host "Creating account in Elastic..."
$body = "{
  `"password`" : `"$new_password`",
  `"roles`" : [ `"$new_role`" ],
  `"full_name`" : `"$new_fullname`",
  `"email`" : `"$new_email`"
}"

$result = Invoke-RestMethod "$targetroot/_security/user/$new_username" -Method POST -Credential $credential -Body $body -ContentType "application/json"

# Store password in KeyVault
Write-Host "Storing password in Key Vault..."
az keyvault secret set --vault-name $(keyVaultName) --name "$($new_username)Password" --value "$new_password"

