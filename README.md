# Para o One Block
(Get-Content docker-compose.yml) -replace 'LEVEL_NAME: "Bedrock level"', 'LEVEL_NAME: "OneBlock"' | Set-Content docker-compose.yml
docker compose up -d --force-recreate mc-bedrock

# Para voltar ao mundo da família
(Get-Content docker-compose.yml) -replace 'LEVEL_NAME: "OneBlock"', 'LEVEL_NAME: "Bedrock level"' | Set-Content docker-compose.yml
docker compose up -d --force-recreate mc-bedrock