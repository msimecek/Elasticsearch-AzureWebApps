# Elasticsearch on Azure Web Apps for Containers

with x-pack

## Supporting pipeline scripts

*Parse deployment outputs and populate variables (`PowerShell`)*

```powershell
$var = ConvertFrom-Json '$(deploymentOutputs)'

Write-Host "##vso[task.setvariable variable=webAppName;]$($var.webAppName.value)"
Write-Host "##vso[task.setvariable variable=keyVaultName;]$($var.keyVaultName.value)"
```

*Add DevOps principal permissions to KeyVault (`Azure PowerShell`)*

```powershell
$applicationId = (Get-AzContext).Account.Id
$principal = Get-AzADServicePrincipal -ApplicationId $applicationId

Set-AzKeyVaultAccessPolicy -VaultName $(keyVaultName) -ObjectId $principal.Id -PermissionsToSecrets Get,List,Set
```

*Remove DevOps principal permissions to KeyVault (`Azure PowerShell`)*

```powershell
$applicationId = (Get-AzContext).Account.Id
$principal = Get-AzADServicePrincipal -ApplicationId $applicationId

Remove-AzKeyVaultAccessPolicy -VaultName $(keyVaultName) -ObjectId $principal.Id
```