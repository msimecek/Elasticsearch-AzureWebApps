# Url of the Elasticsearch instnace on Azure Web Apps.
$targetroot = "https://[your app].azurewebsites.net"
# Username to change password for. Initially run for "elastic".
$username = "elastic"
$pass = "[elastic password]"

$role_name = "index_admin"

# -----------

$secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $secpasswd)

$body = "{
  `"cluster`": [`"all`"],
  `"indices`": [
    {
      `"names`": [ `"all`" ],
      `"privileges`": [`"all`"]
    }
  ]
}"

$result = Invoke-RestMethod "$targetroot/_security/role/$role_name" -Method POST -Credential $credential -Body $body -ContentType "application/json"
