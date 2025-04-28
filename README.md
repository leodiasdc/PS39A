# PS39A
O código inicia dois contâineres no Docker, através do arquivo `docker-compose.yaml`
Para rodar, devem ser utilizados o seguinte comando no terminal:
```bash
docker compose up -d
```
Após isso, deve-se popular o banco de dados através do arquivo `init.sql`. Para fazer isso, rode os seguintes comandos:
```bash
# Copie o arquivo para o container
docker cp init.sql postgres_n8n:/init.sql

# Execute o script
docker exec -it postgres_n8n psql -U n8n -d energiasolar -f /init.sql
```
Após isso, entre na instância do n8n através do seguinte link: http://localhost:5678/home/workflows
Com isso, o workflow configurado no arquivo `PS39A.json` pode ser importado.
É feito um `GET` via o seguinte URL de Endpoint: http://localhost:5678/webhook-test/consumo
Após isso, a query para pegar os dados é descrita no arquivo `media_consumo.sql`. Essa query é feita ao banco de dados, que então utiliza o script `script_outlier.json` para identificar os Outliers. O algoritmo implementado foi o de se a média de consumo do cliente estiver
da seguinte forma:
```math
|M-M_{geral}| > 25 \% \cdot M_{geral}
```
Então é classificado como Outlier. O output é um JSON da forma, para cada um dos clientes: 

```
  {
    "cliente": "Nome do Cliente
    "media_consumo": "Média de Consumo"
    "status": "Normal/Outlier"
  },
```

Finalmente, o último passo é passar esses Outputs para um LLM do modelo `gpt-o4-mini` para que ele faça um breve relatório dos dados fornecidos. O Workflow final ficou da seguinte forma:

![image](https://github.com/user-attachments/assets/5b73d7d6-be00-4f1a-a602-7823f3fa092e)
