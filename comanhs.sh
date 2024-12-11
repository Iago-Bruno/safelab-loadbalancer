# Subir os nós
docker run -d -p 80 --name node1 --hostname node1 --network safelab-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./app.conf:/etc/nginx/conf.d/default.conf nginx:alpine
docker run -d -p 80 --name node2 --hostname node2 --network safelab-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./app.conf:/etc/nginx/conf.d/default.conf nginx:alpine
docker run -d -p 80 --name node3 --hostname node3 --network safelab-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./app.conf:/etc/nginx/conf.d/default.conf nginx:alpine
docker run -d -p 80 --name node4 --hostname node4 --network safelab-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./app.conf:/etc/nginx/conf.d/default.conf nginx:alpine
docker run -d -p 80 --name node5 --hostname node5 --network safelab-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./app.conf:/etc/nginx/conf.d/default.conf nginx:alpine

# Subir o LB
docker run -it -p 80:80 -v ./default.conf:/etc/nginx/conf.d/default.conf --name loadbalancer --hostname loadbalancer --network safelab-network nginx:alpine