az appservice plan create --name demowebappplan42002 --resource-group learning --is-linux

az webapp create --resource-group learning --plan demowebappplan42002  --name demowebapp2002 --deployment-container-image-name democon2002.azurecr.io/dotnetapp:latest

az webapp config appsettings set --resource-group learning  --name demowebapp2002 --settings WEBSITES_PORT=80

$svp = $(az webapp identity assign --resource-group learning --name demowebapp2002 --query principalId --output tsv)

$subid = $(az account show --query id --output tsv)

az role assignment create --assignee $svp --scope /subscriptions/$subid/resourceGroups/learning/providers/Microsoft.ContainerRegistry/registries/democon2002 --role "AcrPull"

az resource update --ids /subscriptions/$subid/resourceGroups/learning/providers/Microsoft.Web/sites/demowebapp2002/config/web --set properties.acrUseManagedIdentityCreds=True

az webapp config container set --name demowebapp2002 --resource-group learning --docker-custom-image-name democon2002.azurecr.io/dotnetapp:latest --docker-registry-server-url https://democon2002.azurecr.io
