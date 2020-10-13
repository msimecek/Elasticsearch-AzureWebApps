# Url of the Elasticsearch instnace on Azure Web Apps.
$targetroot = "https://[your app].azurewebsites.net"
# Username to change password for. Initially run for "elastic".
$admin_username = "elastic"
$admin_pass = "[elastic password]"

# Change these...
$user_username = "testy"
$user_password = "tester"
$user_fullname = "Testy Tester"
$user_email = "testy@test.com"
$user_role = "indexuser"
# -----------

$secpasswd = ConvertTo-SecureString $admin_pass -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($admin_username, $secpasswd)

$body = "{
  `"password`" : `"$user_password`",
  `"roles`" : [ `"$user_role`" ],
  `"full_name`" : `"$user_fullname`",
  `"email`" : `"$user_email`"
}"

$result = Invoke-RestMethod "$targetroot/_security/user/$user_username" -Method POST -Credential $credential -Body $body -ContentType "application/json"
