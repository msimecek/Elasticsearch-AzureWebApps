# Url of the Elasticsearch instnace on Azure Web Apps.
$targetroot = "https://[your app].azurewebsites.net"
# Username to change password for. Initially run for "elastic".
$username = "elastic"
# Password which was set during deployment.
$bootstrapPass = "s3cr3t"
# New password.
$newPass = "[elastic new password]"

# ---------------------

$secpasswd = ConvertTo-SecureString $bootstrapPass -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $secpasswd)

$result = Invoke-RestMethod "$targetroot/_security/user/_password" -Method POST -Credential $credential -Body "{`"password`" : `"$newPass`"}" -ContentType "application/json"

# ---------------------

# Finally, use Azure CLI, portal or CI/CD to remove the ELASTIC_PASSWORD Application Setting from Azure.
# az webapp config appsettings delete --name MyWebApp --resource-group MyResourceGroup --setting-names ELASTIC_PASSWORD