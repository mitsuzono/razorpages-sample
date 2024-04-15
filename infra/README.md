# razorpages-sample-infra

## Installation

https://learn.microsoft.com/ja-jp/cli/azure/install-azure-cli

## Usage

`main.parameter.json` にリソース名とSQLServerログイン情報を入力しておきます。  
例：

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "resource_suffix": {
            "value": "mitsuzono-workshop202404-001"
        },
        "sql_login_id": {
            "value": "mitsuzono"
        },
        "sql_login_pass": {
            "value": "!Qaz2wsx"
        }
    }
}
```

下記コマンドを参考に、 `az deployment group create` を実行します。

```bash
# login
az login

# set account
az account set -s <Subscription ID>
az account show -o table

# create resource group
az group create -l japaneast -n <RESOURCE_GROUP_NAME>

# deploy
az deployment group create --resource-group <RESOURCE_GROUP_NAME> --template-file main.bicep --parameters main.parameters.json --confirm-with-what-if
```
