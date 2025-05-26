# Subir os nós
docker run -d -p 80 --name node1 --hostname node1 --network safelab-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./app.conf:/etc/nginx/conf.d/default.conf nginx:alpine
docker run -d -p 80 --name node2 --hostname node2 --network safelab-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./app.conf:/etc/nginx/conf.d/default.conf nginx:alpine
docker run -d -p 80 --name node3 --hostname node3 --network safelab-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./app.conf:/etc/nginx/conf.d/default.conf nginx:alpine
docker run -d -p 80 --name node4 --hostname node4 --network safelab-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./app.conf:/etc/nginx/conf.d/default.conf nginx:alpine
docker run -d -p 80 --name node5 --hostname node5 --network safelab-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./app.conf:/etc/nginx/conf.d/default.conf nginx:alpine

# Subir o LB
docker run -it -p 80:80 -v ./default.conf:/etc/nginx/conf.d/default.conf --name loadbalancer --hostname loadbalancer --network safelab-network nginx:alpine

# Roda o docker passando o projeto manualmente no dockerfile
docker build -t safelab-image .

# Roda o docker passando o token do o link do repositório privado diretamente
docker build --build-arg GITHUB_TOKEN=$GITHUB_TOKEN -t safelab-image .

# Roda o docker passando o link do repositório privado por variáveis de ambiente do .env
export $(grep -v '^#' .env | xargs) && docker build --build-arg GITHUB_TOKEN=$GITHUB_TOKEN -t safelab-image .

# Roda a imagem criada
docker run -p 80:80 safelab-image

# Comando completo
export $(grep -v '^#' .env | xargs) && docker build --build-arg GITHUB_TOKEN=$GITHUB_TOKEN -t safelab-image . && docker run -p 80:80 safelab-image
