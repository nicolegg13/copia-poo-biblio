# copia-poo-biblio
## Trabalho de POOW: gerenciamento de biblioteca (autores, livros e empréstimos)

#### Administrador (acesso total):
- admin@biblioteca.com
- admin123

#### Usuário (acesso aos empréstimos):
- usuario@biblioteca.com
- user123

### Requisito adaptado (Dockerfile):
##### ENTRYPOINT para iniciar o projeto
- a imagem oficial do tomcat é projetada para ser iniciada com CMD ["catalina.sh", "run"]
- ENTRYPOINT é usado para definir o executável principal de um contêiner, e o CMD fornece os argumentos padrão para esse executável 
- CMD também garante a inicialização automática da aplicação
