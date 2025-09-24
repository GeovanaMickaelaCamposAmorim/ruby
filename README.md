# 🎬 Studio Ghibli Films Database

Um aplicativo em **Ruby** que consome a **API pública do Studio Ghibli**, armazena os dados em **PostgreSQL** e fornece uma interface de linha de comando simples e intuitiva para consultas.

---

## 📋 Índice
- [Descrição do Projeto](#-descrição-do-projeto)
- [Funcionalidades](#-funcionalidades)
- [Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [Pré-requisitos](#-pré-requisitos)
- [Instalação e Configuração](#-instalação-e-configuração)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [API Consumida](#-api-consumida)
- [Banco de Dados](#-banco-de-dados)
- [Como Usar](#-como-usar)
- [Exemplos de Uso](#-exemplos-de-uso)
- [Troubleshooting](#-troubleshooting)
- [Contribuindo](#-contribuindo)
- [Licença](#-licença)
- [Autoria](#-autoria)

---

## 🎯 Descrição do Projeto
Este projeto foi desenvolvido para fins educacionais, com os seguintes objetivos:
- Consumir a API pública do Studio Ghibli e coletar informações sobre os filmes
- Armazenar os dados em um banco PostgreSQL
- Fornecer um menu interativo em linha de comando para consultas
- Demonstrar **consumo de APIs REST**, **persistência de dados** e **Programação Orientada a Objetos (POO)** em Ruby

---

## ✨ Funcionalidades
- **Importação de dados**: inteligente, evita duplicação e permite sobrescrever registros  
- **Sistema de buscas**: listagem completa, pesquisa por título, diretor ou ano de lançamento  
- **Top avaliados**: exibe os 5 filmes com melhor avaliação  
- **Estatísticas gerais**: total de filmes, média de avaliação, filme mais antigo e mais recente  

---

## 🛠 Tecnologias Utilizadas
- **Ruby** (>= 2.7)  
- **PostgreSQL** (>= 12)  
- **Gems**: `pg`, `sequel`, `httparty`, `json`  

---

## 📋 Pré-requisitos
- Ruby instalado (2.7 ou superior)  
- PostgreSQL (12 ou superior)  
- Git  
- Bundler (`gem install bundler`)  
- Acesso ao PostgreSQL com permissão para criar bancos de dados  

---

## 🚀 Instalação e Configuração

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/ghibli-films-database.git
   cd ghibli-films-database
2. Instale as dependências:

bundle install


##  3. Crie o banco de dados no PostgreSQL:

CREATE DATABASE ghibli_films;


4. Crie a tabela:

\c ghibli_films;

CREATE TABLE films (
    id SERIAL PRIMARY KEY,
    ghibli_id VARCHAR(50) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    original_title VARCHAR(255),
    original_title_romanised VARCHAR(255),
    description TEXT,
    director VARCHAR(100),
    producer VARCHAR(100),
    release_year INTEGER,
    running_time INTEGER,
    rt_score INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_films_title ON films(title);
CREATE INDEX idx_films_director ON films(director);
CREATE INDEX idx_films_release_year ON films(release_year);


5. Configure as credenciais no arquivo services/database_service.rb:

DB_CONFIG = {
  host: 'localhost',
  port: 5432,
  dbname: 'ghibli_films',
  user: 'seu_usuario',
  password: 'sua_senha'
}.freeze

📁 Estrutura do Projeto
ghibli-films-database/
├── README.md
├── Gemfile
├── main.rb
├── funcoes/
│   └── app.rb
└── services/
    ├── database_service.rb
    └── ghibli_api_service.rb

🌐 API Utilizada

Base URL: https://ghibliapi.vercel.app/films

Autenticação: Não requerida

Dados: Títulos, diretores, produtores, anos, duração, descrição e notas

🎮 Como Usar

Execute o programa principal:

ruby main.rb


Menu exibido:

📋 MENU PRINCIPAL
1. 📥 Importar filmes da API
2. 📋 Listar todos os filmes
3. 🔍 Buscar por título
4. 👨‍💼 Buscar por diretor
5. 📅 Buscar por ano
6. ⭐ Top 5 melhores avaliações
7. 📊 Estatísticas
0. ❌ Sair

💡 Exemplos de Uso
Importação inicial
📥 Importando 22 filmes...
✅ NOVO: Castle in the Sky
✅ NOVO: Grave of the Fireflies
...
🎉 Importação concluída!

Estatísticas
📊 ESTATÍSTICAS GERAIS
📈 Total de filmes: 22
⭐ Média de avaliação: 87.3%
🆕 Ano mais recente: 2020
🕰️ Ano mais antigo: 1986

🔧 Troubleshooting

❌ Erro de conexão ao banco → verifique credenciais e se o PostgreSQL está rodando

❌ Permissão negada → garanta que o usuário tem privilégios de criação

❌ API fora do ar → teste sua conexão com internet

🤝 Contribuindo

Faça um fork do projeto

Crie uma branch (git checkout -b feature/minha-feature)

Commit suas alterações (git commit -m "feat: minha feature")

Push (git push origin feature/minha-feature)

Abra um Pull Request

📄 Licença

Distribuído sob a Licença MIT. Veja o arquivo LICENSE para mais detalhes.
Projeto educacional utilizando dados da API pública do Studio Ghibli.

✍️ Autoria

Geovana Mickaela Campos Amorim
Desenvolvido como projeto educacional para praticar consumo de APIs, POO em Ruby e persistência em PostgreSQL.
