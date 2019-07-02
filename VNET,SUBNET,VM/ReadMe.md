# Deploying a VNet and VM using Terraform in Azure
Terraform provides an easy way to define, preview, and deploy cloud infrastructure by using a simple templating language. 

Steps:<br/>
On the Azure CLI type the commands
```bash
az account set --subscription="${SUBSCRIPTION_ID}"
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"

echo "Setting environment variables for Terraform"
export ARM_SUBSCRIPTION_ID=your_subscription_id
export ARM_CLIENT_ID=your_appId
export ARM_CLIENT_SECRET=your_password
export ARM_TENANT_ID=your_tenant_id
export ARM_ENVIRONMENT=public
```

Use the .tf file <br/>

### To Deploy
```bash 
terraform init
terraform plan
terraform apply
```

