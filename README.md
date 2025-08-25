# Dojo System
Sistema para gerenciamento de academias de lutas, que permite às academias se organizarem de forma simples e eficiente. Além disso, oferece um portal onde alunos matriculados e interessados podem acessar informações sobre planos, modalidades, professores e outros serviços.

## Tecnologias
- Node.js (com NestJS)
- Angular
- MongoDB
- Docker

## Instalção e execução do Projeto
### Pré-requisitos
1. **Docker**
   - Para execução do projeto, é necessário ter instalado o docker
   - Caso não tenha instalado, é possível instalar através do [Docker Docs](https://docs.docker.com/engine/install/)
   - Verificar se o docker está instalado:
     ```bash
     docker -v
     ```

2. **Config variáveis do `.env.development`**  
   Use `.env.example` como referência para criar seu arquivo de configuração `.env.development`  
   Ex:
   ```yaml
   MONGODB_URI=mongodb://mongodb:27017/db_dojo_system # URI do container do mongo

   JWT_SECRET=secret
   JWT_EXPIRATION_TIME=1d
   ```

### Processo de Execução
1. Clonar o repositório na sua máquina
```bash
git clone git@github.com:Axiotes/dojo-system.git
```
2. Entrar no diretório
```bash
cd dojo-system
```
3. Executar build
```bash
docker-compose build
```
4. Executar aplicação
```bash
docker-compose up
```

## Documentação
Toda a documentação detalhada do projeto está disponível em [Dojo System Docs](https://docs-dojo-system.vercel.app/about/)

### Conteúdo da documentação
- **Visão Geral**: explicação sobre o sistema e seu objetivo.
- **Partes Interessadas**: quem utiliza o sistema e quais papéis existem.
- **Requisitos**
- **Guia de Execução**: como rodar o projeto localmente.
- **Frontend**: tecnologias utilizadas, componetes e telas desenvolvidas.
- **Backend**: collections, endpoints disponíveis e exemplos de uso.
