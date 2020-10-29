# Just the name of Azure Web App without https and azurewebsites.net.
$webAppName = $args[0]
# Password of the elastic user.
$elasticPassword = $args[1]

# ------

$targetroot = "https://$($webAppName).azurewebsites.net"
$elastic_username = "elastic"
$elastic_pass = "$($elasticPassword)"

$secpasswd = ConvertTo-SecureString $elastic_pass -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($elastic_username, $secpasswd)

# ----

# Index admin role has privileges to do anything with indexes.
Write-Host "Creating index_admin role..."
$role_name = "index_admin"
$body = "{
  `"cluster`": [`"all`"],
  `"indices`": [
    {
      `"names`": [ `"*`" ],
      `"privileges`": [`"all`"]
    }
  ]
}"

$result = Invoke-RestMethod "$targetroot/_security/role/$role_name" -Method POST -Credential $credential -Body $body -ContentType "application/json"

# Index user role has privileges to read/write indexes.
Write-Host "Creating index_user role..."
$role_name = "index_user"
$body = "{
  `"cluster`": [`"all`"],
  `"indices`": [
    {
      `"names`": [ `"all`" ],
      `"privileges`": [`"read`", `"write`"]
    }
  ]
}"

$result = Invoke-RestMethod "$targetroot/_security/role/$role_name" -Method POST -Credential $credential -Body $body -ContentType "application/json"
