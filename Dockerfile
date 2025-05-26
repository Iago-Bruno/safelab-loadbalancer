# Usa imagem do node para criar um ambiente de build
FROM node:22-alpine AS build

# Define diretorio raiz dentro do container
WORKDIR /app

# Baixa e instala o git
RUN apk add --no-cache git

# Define argumento passado no comando de execução
# Usado apenas no build
ARG GITHUB_TOKEN

# Clonar repositorio privado passando o token
RUN git clone https://${GITHUB_TOKEN}@github.com/Iago-Bruno/front-safelab.git .

# Verificar o conteúdo do diretório para garantir que o clone foi bem-sucedido
RUN ls -la /app

# Baixa dependências do projeto
RUN npm install

# Verificar se o Vite foi instalado corretamente
RUN npm list vite

# Rodar o build e capturar o log de erro
RUN npm run build || echo "Build Falhou"

# Verifica se a pasta build foi criada
RUN ls -la /app/build || echo "Sem arquivos do build"

# Usa imagem do Nginx para servir a aplicação
FROM nginx:alpine

# Define diretorio raiz para ficar o html da aplicação
WORKDIR /usr/share/nginx/html

# Copia os arquivos de build para a raiz do html
COPY --from=build /app/dist .

# Expõe a aplicação na porta 80
EXPOSE 80

# Define o fim do código
# Roda o nginx em 'foreground'
CMD ["nginx", "-g", "daemon off;"]
