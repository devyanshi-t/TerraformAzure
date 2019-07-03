
# Deploying  an ARM template  using Terraform in Azure
Terraform provides an easy way to define, preview, and deploy cloud infrastructure by using a simple templating language. 
In this example an ARM template is deployed using terraform.

## Steps:<br/>

-  ### On the Azure CLI type the commands

<a href="https://shell.azure.com" target="_blank">
<img name="launch-cloud-shell" src="https://docs.microsoft.com/azure/includes/media/cloud-shell-try-it/launchcloudshell.png" data-linktype="external">
</a></br>


```az account set --subscription="${SUBSCRIPTION_ID}"
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"

echo "Setting environment variables for Terraform"
export ARM_SUBSCRIPTION_ID=your_subscription_id
export ARM_CLIENT_ID=your_appId
export ARM_CLIENT_SECRET=your_password
export ARM_TENANT_ID=your_tenant_id
export ARM_ENVIRONMENT=public
```




- ### Use the .tf file 

<a href="https://shell.azure.com" target="_blank">
<img name="launch-cloud-shell" src="https://docs.microsoft.com/azure/includes/media/cloud-shell-try-it/launchcloudshell.png" data-linktype="external">
</a></br>

    To Deploy
        
        terraform init
        terraform plan
        terraform apply



