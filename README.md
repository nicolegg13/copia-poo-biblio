# copia-poo-biblio
## Trabalho de POOW: gerenciamento de biblioteca (autores, livros e empréstimos)

#### Administrador (acesso total):
- admin@biblioteca.com
- admin123

#### Usuário (acesso aos empréstimos):
- usuario@biblioteca.com
- user123

### Requisitos adaptados (Dockerfile):
##### Clonar o projeto do GitHub dentro do Dockerfile
- essa abordagem causou um problema persistente de cache do Docker, onde as atualizações do código no GitHub não eram repassadas no build
- então usei o comando COPY para copiar os arquivos locais para a imagem -- qualquer alteração no código invalida o cache e força uma nova compilação (mais confiável)

##### ENTRYPOINT para iniciar o projeto
- a imagem oficial do tomcat é projetada para ser iniciada com CMD ["catalina.sh", "run"]
- ENTRYPOINT é usado para definir o executável principal de um contêiner, e o CMD fornece os argumentos padrão para esse executável 
- CMD também garante a inicialização automática da aplicação
