# safelab-loadbalancer

## Configuração do loadbalancer

### Configuração do arquivo default.conf

#### ip de conexão dos nodes

```
upstream nodes {
    server 172.19.0.2;
    server 172.19.0.3;
    server 172.19.0.4;
    server 172.19.0.5;
    server 172.19.0.6;
}
```

#### Explicação das configurações adicionadas para a atividade

Indica que será colocado no header das requests ao nginx o ip da máquina que acessou a apli

`proxy_set_header X-Real-IP $remote_addr`

Indica que será permitido a escrita de logs no loadbalancer e nos nodes no arquivo de log 'nginx-access.log'

`access_log /var/log/nginx/nginx-access_log`

## Configuração dos nodes

### Configuração do arquivo nginx.conf

#### Explicação das configurações adicionadas para a atividade

Define o formato dos logs que iram gerar nos arquivos de logs dos nodes

```
log_format  main  '$http_x_real_ip - $remote_user [$time_local] "$request" '
                  '$status $body_bytes_sent "$http_referer" '
                  '"$http_user_agent" "$http_x_forwarded_for"';
```

Principal mudança no formato do log que permite exibir o IP das requisições

`$http_x_real_ip`

Permite que os logs vão ser escritos no arquivo 'nginx.access.log' seguindo o formato de log 'main' das configurações

`access_log  /var/log/nginx/nginx-access.log  main`

### Configuração do arquivo app.conf (Opcional para a atividade)

#### Esse arquivo foi criado e usado com a finalidade de fazer os ajustes necessários para os arquivos de configurações default.conf dos nodes

Foi adicionado a linha abaixo no 'location /' para que fosse permitido fazer as navegações entre telas pela aplicação do react

`try_files $uri /index.html`

## Explicação do comandos para criação e execução do loadbalancer e nodes

### Comando do loadbalancer

Indica que a porta 80 está liberada para acesso pelo host

`-p 80:80`

Redirecionamento do arquivo de configuração local 'default.conf' para o arquivo padrão do nginx

`-v ./default.conf:/etc/nginx/conf.d/default.conf`

Define o nome do container para 'loadbalancer'

`--name loadbalancer --hostname loadbalancer`

No comando do loadbalancer foi adicionado o código abaixo com a finalidade de criar e deixar um network docker personalizado em conjunto com os nodes

`--network safelab-network`

### Comando dos nodes

Indica que o node vai rodar na porta 80

`-p 80`

Define o nome do container e do node

`--name node5 --hostname node5`

No comando do Node foi adicionado o código abaixo para definir em qual network docker os nodes irão rodar

`--network safelab-network`

Define a pasta 'dist' de build da aplicação react para ser usada pelas requests nos nodes

`-v ./dist:/usr/share/nginx/html`

Define que o arquivo loca 'nginx.conf' será usado como configuração no lugar do padrão do nginx

`-v ./nginx.conf:/etc/nginx/nginx.conf`

Define que o arquivo 'app.conf' será usado como configuração para a aplicação react rodando nos nodes

`-v ./app.conf:/etc/nginx/conf.d/default.conf`
