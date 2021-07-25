az appservice plan create --name demowebappplan42002 --resource-group learning --is-linux

az webapp create --resource-group learning --plan demowebappplan42002  --name demowebapp2002 --deployment-container-image-name nginx