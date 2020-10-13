# Url of the Elasticsearch instnace on Azure Web Apps.
$targetroot = "https://[your app].azurewebsites.net"
# Username to change password for. Initially run for "elastic".
$admin_username = "elastic"
$admin_pass = "[elastic password]"

$user = ""
$assigned_role = ""

# -----------

$secpasswd = ConvertTo-SecureString $admin_pass -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($admin_username, $secpasswd)

# $body = "{
#   `"cluster`": [`"all`"],
#   `"indices`": [
#     {
#       `"names`": [ `"all`" ],
#       `"privileges`": [`"read`", `"write`"]
#     }
#   ]
# }"

# $result = Invoke-RestMethod "$targetroot/_security/role/indexuser" -Method POST -Credential $credential -Body $body -ContentType "application/json"
