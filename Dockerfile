# multi-stage build: compila código com maven, pega arquivo .war e coloca em servidor wildfly - imagem final menor

# estágio 1 -- builder -- imagem oficial do maven com java 17
FROM maven:3.9.4-eclipse-temurin-17 AS builder