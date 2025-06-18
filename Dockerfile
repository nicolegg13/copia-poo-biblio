# Estágio 1: Build da Aplicação a partir do GitHub
FROM maven:3.9-eclipse-temurin-17 AS build

# Instala o Git
RUN apt-get update && apt-get install -y git

# Clona o projeto do GitHub
WORKDIR /app
RUN git clone https://github.com/nicolegg13/copia-poo-biblio.git .

# Executa o build do Maven para garantir que todas as dependências sejam baixadas e o projeto compilado
RUN mvn clean package

# Estágio 2: Ambiente de Execução
FROM tomcat:10.1-jdk17-temurin

# Remove o conteúdo padrão da pasta webapps do Tomcat. 
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia o arquivo .war gerado no estágio anterior para a pasta webapps do Tomcat.
# Renomeia para ROOT.war para a aplicação rodar na raiz do servidor. 
COPY --from=build /app/target/biblioteca.war /usr/local/tomcat/webapps/ROOT.war

# Expõe a porta 8080 para o mundo exterior.
EXPOSE 8080

# Comando para iniciar o servidor Tomcat. 
CMD ["catalina.sh", "run"]