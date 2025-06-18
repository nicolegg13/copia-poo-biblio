# como a imagem da aplicação é construída, de forma otimizada -- multi-stage build (separando o build do runtime)
# adaptações

# estágio 1: build da aplicação
# imagem oficial do Maven com o JDK 17 para compilar o projeto
FROM maven:3.9-eclipse-temurin-17 AS build

# define o diretório de trabalho no container
WORKDIR /app

# copia o pom.xml primeiro e baixa as dependências - se ele não mudar, o Docker reutiliza o cache do download das dependências
COPY pom.xml .
RUN mvn dependency:go-offline

# "Escrever um Dockerfile para clonar o projeto do GitHub"
# 'RUN git clone' gerou problema de cache no Docker (mesmo após corrigir os códigos, o Docker continuava usando a versão antiga, do cache), 
# então: em vez de clonar dentro do Dockerfile, sincronizo o código local com o github (git add ., git commit -m e git push) e o Dockerfile copia os códigos para dentro da imagem (COPY)
# a cada alteração o código, o cache do Docker é invalidado e um novo build é feito

# copia o resto do código fonte
COPY src ./src
# compila o código e gera o arquivo .war
RUN mvn clean package


# estágio 2: execução
# imagem oficial do Tomcat
FROM tomcat:10.1-jdk17-temurin

# remove o conteúdo padrão da pasta webapps do Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# copia apenas o arquivo .war para a pasta webapps do Tomcat, renomeando-o para ROOT.war - acessível na raiz do servidor
COPY --from=build /app/target/biblioteca.war /usr/local/tomcat/webapps/ROOT.war

# expõe a porta 8080
EXPOSE 8080

# inicia o servidor Tomcat
CMD ["catalina.sh", "run"]

# "Colocar o comando correto para inicialização do projeto no ENTRYPOINT"
# a imagem oficial do Tomcat já define o ENTRYPOINT, e é iniciada com o comando 'CMD ["catalina.sh", "run"]'
    # define o processo principal do container
    # ENTRYPOINT define o comando que será executado quando o container for iniciado
    # a documentação da imagem do Tomcat recomenda usar o comando 'CMD' para iniciar o servidor