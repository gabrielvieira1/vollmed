# 🏥 VollMed - Sistema de Gestão Médica

Sistema de gerenciamento médico desenvolvido em Node.js com TypeScript, TypeORM e MySQL. A API permite gerenciar pacientes, especialistas, clínicas, consultas e avaliações.

## 📋 Pré-requisitos

- Docker
- Docker Compose
- Make

## 🏗️ Estrutura do Projeto

```
vollmed/
├── packages/
│   ├── api/           # API REST (Node.js + TypeScript)
│   ├── frontend/      # Interface do usuário (HTML/CSS/JS)
│   └── infra/         # Infraestrutura (Terraform, K8s, etc.)
├── database/          # Scripts SQL e migrações
├── docs/              # Documentação
├── docker-compose.yaml
├── Makefile
└── package.json
```

## 🚀 Quick Start

### Usando Docker (Recomendado)

```bash
# Iniciar toda a aplicação
make up

# Visualizar logs
make logs

# Parar aplicação
make down
```

### Desenvolvimento Local

```bash
# Instalar dependências
make install

# Iniciar desenvolvimento
make dev
```

## 🌐 URLs da Aplicação

- **API**: http://localhost:3000
- **Frontend**: http://localhost:3001
- **Database**: localhost:3306
- **Redis**: localhost:6379

## 📋 Comandos Disponíveis

### 🚀 Principais

| Comando | Descrição |
|---------|-----------|
| `make up` | Inicia toda a aplicação (rápido) |
| `make up-build` | Inicia com rebuild (quando necessário) |
| `make down` | Para toda a aplicação |
| `make logs` | Visualiza logs em tempo real |
| `make help` | Lista todos os comandos disponíveis |

### 📊 Logs Específicos

| Comando | Descrição |
|---------|-----------|
| `make logs-api` | Logs apenas da API |
| `make logs-frontend` | Logs apenas do Frontend |
| `make logs-db` | Logs apenas do Banco |

### 🔧 Desenvolvimento

| Comando | Descrição |
|---------|-----------|
| `make install` | Instala dependências |
| `make dev` | Desenvolvimento local |
| `make build` | Build de todos os projetos |
| `make test` | Executa testes |
| `make lint` | Executa lint |
| `make lint-fix` | Corrige problemas de lint |

### 🔄 Utilitários

| Comando | Descrição |
|---------|-----------|
| `make clean` | Para e remove volumes (limpa dados) |
| `make status` | Status dos containers |
| `make restart-api` | Reinicia apenas a API |
| `make restart-frontend` | Reinicia apenas o Frontend |
| `make restart-db` | Reinicia apenas o Banco |

## 📦 Workspaces

Este projeto usa npm workspaces para gerenciar múltiplos pacotes:

- `@vollmed/api` - API REST
- `@vollmed/frontend` - Interface do usuário
- `@vollmed/infra` - Infraestrutura

## 🛠️ Tecnologias

- **Backend**: Node.js, TypeScript, Express, MySQL, Redis
- **Frontend**: HTML, CSS, JavaScript, Nginx
- **Infraestrutura**: Docker, Docker Compose
- **Banco de Dados**: MySQL
- **Cache**: Redis

## 🗃️ Banco de Dados

O banco de dados MySQL será iniciado automaticamente e populado com dados iniciais.

- Host: localhost
- Porta: 3306  
- Database: testemed
- Usuário: root
- Senha: root

## 📚 Documentação da API

### 🔐 Autenticação

#### **POST** `/auth/login`
Realiza login no sistema
```json
{
  "email": "user@email.com",
  "senha": "password",
  "tipo": "paciente" // ou "especialista" ou "clinica"
}
```

#### **POST** `/auth/logout`
Realiza logout (requer token)

#### **POST** `/auth/refresh`
Renova token de acesso

---

### 🏥 Pacientes

#### **GET** `/paciente`
Lista todos os pacientes

#### **POST** `/paciente`
Cria um novo paciente
```json
{
  "nome": "João Silva",
  "cpf": "12345678901",
  "email": "joao@email.com",
  "senha": "senha123",
  "telefone": "(11) 99999-9999",
  "estaAtivo": true,
  "possuiPlanoSaude": true,
  "planosSaude": [1, 2],
  "endereco": {
    "cep": "01234-567",
    "rua": "Rua das Flores",
    "numero": "123",
    "estado": "SP",
    "complemento": "Apto 45"
  }
}
```

#### **GET** `/paciente/:id`
Busca paciente por ID

#### **PUT** `/paciente/:id`
Atualiza dados do paciente (requer autenticação como paciente)

#### **DELETE** `/paciente/:id`
Desativa paciente (requer autenticação como paciente)

#### **PATCH** `/paciente/:id`
Atualiza endereço do paciente (requer autenticação como paciente)

#### **GET** `/paciente/:id/consultas`
Lista consultas do paciente

#### **GET** `/paciente/consulta-por-paciente`
Busca pacientes por nome (vulnerável - SQL injection)

---

### 👨‍⚕️ Especialistas

#### **GET** `/especialista`
Lista todos os especialistas

#### **POST** `/especialista`
Cria um novo especialista (requer autenticação como clínica)
```json
{
  "nome": "Dr. Maria Santos",
  "crm": "123456",
  "especialidade": "Cardiologia",
  "email": "maria@email.com",
  "senha": "senha123",
  "telefone": "(11) 88888-8888",
  "estaAtivo": true,
  "possuiPlanoSaude": true,
  "planosSaude": [1, 3],
  "endereco": {
    "cep": "01234-567",
    "rua": "Rua dos Médicos",
    "numero": "456",
    "estado": "SP"
  }
}
```

#### **GET** `/especialista/:id`
Busca especialista por ID

#### **PUT** `/especialista/:id`
Atualiza dados do especialista (requer autenticação como especialista)

#### **DELETE** `/especialista/:id`
Remove especialista (requer autenticação como clínica ou especialista)

#### **PATCH** `/especialista/:id`
Atualiza telefone do especialista

#### **GET** `/especialista/busca`
Busca especialistas por especialidade e estado
```
GET /especialista/busca?especialidade=Cardiologia&estado=SP
```

---

### 🏛️ Clínicas

#### **GET** `/clinica`
Lista todas as clínicas

#### **POST** `/clinica`
Cria uma nova clínica
```json
{
  "nome": "Clínica São João",
  "email": "contato@clinica.com",
  "senha": "senha123",
  "planoDeSaudeAceitos": [1, 2, 3],
  "endereco": {
    "cep": "01234-567",
    "rua": "Rua da Clínica",
    "numero": "789",
    "estado": "SP",
    "complemento": "Sala 101"
  }
}
```

#### **GET** `/clinica/:id`
Busca clínica por ID

#### **PUT** `/clinica/:id`
Atualiza dados da clínica

#### **DELETE** `/clinica/:id`
Remove clínica

#### **GET** `/clinica/:id/especialista`
Lista especialistas de uma clínica

#### **POST** `/clinica/:id/especialista`
Associa especialista a uma clínica
```json
{
  "especialistaId": "specialist-uuid"
}
```

---

### 📅 Consultas

#### **GET** `/consulta`
Lista todas as consultas

#### **POST** `/consulta`
Agenda uma nova consulta
```json
{
  "especialista": "specialist-uuid",
  "paciente": "patient-uuid",
  "data": "2024-12-20T14:30:00",
  "desejaLembrete": true,
  "lembretes": ["SMS", "EMAIL"]
}
```

#### **GET** `/consulta/:id`
Busca consulta por ID

#### **DELETE** `/consulta/:id`
Cancela consulta

---

### ⭐ Avaliações

#### **GET** `/avaliacoes`
Lista todas as avaliações

#### **POST** `/avaliacoes`
Cria uma nova avaliação
```json
{
  "idEspecialista": "specialist-uuid",
  "idPaciente": "patient-uuid",
  "nota": 5,
  "descricao": "Excelente atendimento!"
}
```

---

### 💳 Planos de Saúde

#### **GET** `/planosdesaude`
Lista todos os planos de saúde disponíveis

---

### 🖼️ Imagens de Pacientes

#### **POST** `/paciente/:id/images`
Upload de imagem do paciente (multipart/form-data)

#### **GET** `/paciente/:id/images`
Lista imagens do paciente

#### **DELETE** `/paciente/:id/images`
Remove imagem do paciente (requer autenticação como paciente)

---

## 🔒 Autenticação e Autorização

A API utiliza JWT para autenticação. Após o login, inclua o token no header:

```
Authorization: Bearer <seu-token>
```

### Roles disponíveis:
- **paciente**: Acesso aos próprios dados
- **especialista**: Acesso aos próprios dados e consultas
- **clinica**: Acesso a especialistas e dados da clínica

---

## 📝 Exemplos de Uso

### Criar um paciente:
```bash
curl -X POST http://localhost:3000/paciente \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "João Silva",
    "cpf": "12345678901",
    "email": "joao@email.com",
    "senha": "senha123",
    "telefone": "(11) 99999-9999",
    "endereco": {
      "cep": "01234-567",
      "rua": "Rua das Flores",
      "numero": "123",
      "estado": "SP"
    }
  }'
```

### Fazer login:
```bash
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "joao@email.com",
    "senha": "senha123",
    "tipo": "paciente"
  }'
```

### Listar pacientes:
```bash
curl http://localhost:3000/paciente
```

### Agendar consulta:
```bash
curl -X POST http://localhost:3000/consulta \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <seu-token>" \
  -d '{
    "especialista": "specialist-uuid",
    "paciente": "patient-uuid",
    "data": "2024-12-20T14:30:00",
    "desejaLembrete": true,
    "lembretes": ["SMS"]
  }'
```

## 🛠️ Tecnologias Utilizadas

- **Node.js** - Runtime JavaScript
- **TypeScript** - Linguagem de programação
- **Express** - Framework web
- **TypeORM** - ORM para TypeScript/JavaScript
- **MySQL** - Banco de dados relacional
- **Docker** - Containerização
- **Redis** - Cache e sessões
- **JWT** - Autenticação
- **Multer** - Upload de arquivos

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
