# Estágio 1: Build da Aplicação
# Usamos a imagem oficial do Maven com o JDK 17 para compilar o projeto.
FROM maven:3.9-eclipse-temurin-17 AS build

# Define o diretório de trabalho dentro do container.
WORKDIR /app

# Copia o pom.xml primeiro. Se ele não mudar, o Docker reutiliza o cache do download das dependências.
COPY pom.xml .
RUN mvn dependency:go-offline

# Copia o resto do código-fonte. Se qualquer arquivo em 'src' mudar, esta camada e as seguintes serão reconstruídas.
COPY src ./src
RUN mvn clean package

# Estágio 2: Ambiente de Execução
# Usamos a imagem oficial do Tomcat.
FROM tomcat:10.1-jdk17-temurin

# Remove o conteúdo padrão da pasta webapps do Tomcat.
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia o arquivo .war construído no estágio anterior para a pasta webapps do Tomcat.
# Renomeia para ROOT.war para a aplicação rodar na raiz do servidor.
COPY --from=build /app/target/biblioteca.war /usr/local/tomcat/webapps/ROOT.war

# Expõe a porta 8080.
EXPOSE 8080

# Comando para iniciar o servidor Tomcat.
CMD ["catalina.sh", "run"]