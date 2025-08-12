# Makefile para gerenciar o monorepo VollMed

.PHONY: up up-build down logs clean install dev build test help

# Levanta toda a aplicação (API + Frontend + DB + Redis)
up:
	@echo "🚀 Iniciando VollMed Monorepo..."
	docker-compose up -d
	@echo "✅ Aplicação iniciada com sucesso!"
	@echo "🌐 API disponível em: http://localhost:3000"
	@echo "🎨 Frontend disponível em: http://localhost:3001"
	@echo "📊 Logs: make logs"

# Levanta com rebuild (usar quando necessário)
up-build:
	@echo "🚀 Iniciando VollMed Monorepo com rebuild..."
	docker-compose up --build -d
	@echo "✅ Aplicação iniciada com sucesso!"
	@echo "🌐 API disponível em: http://localhost:3000"
	@echo "🎨 Frontend disponível em: http://localhost:3001"
	@echo "📊 Logs: make logs"

# Para todos os containers
down:
	@echo "🛑 Parando todos os containers do VollMed..."
	docker-compose down
	@echo "✅ Containers parados com sucesso!"

# Visualiza os logs de todos os serviços
logs:
	@echo "📋 Exibindo logs do VollMed..."
	docker-compose logs -f

# Logs específicos por serviço
logs-api:
	@echo "📋 Exibindo logs da API..."
	docker-compose logs -f api

logs-frontend:
	@echo "📋 Exibindo logs do Frontend..."
	docker-compose logs -f frontend

logs-db:
	@echo "📋 Exibindo logs do Banco..."
	docker-compose logs -f db

# Para e remove volumes (limpa todos os dados)
clean:
	@echo "🧹 Parando containers e removendo volumes..."
	docker-compose down -v
	@echo "🗑️  Dados removidos com sucesso!"

# Instala dependências em todos os workspaces
install:
	@echo "📦 Instalando dependências..."
	npm install
	@echo "✅ Dependências instaladas!"

# Desenvolvimento local (sem Docker)
dev:
	@echo "🔧 Iniciando desenvolvimento local..."
	npm run dev

# Build de todos os projetos
build:
	@echo "🏗️  Buildando todos os projetos..."
	npm run build
	@echo "✅ Build concluído!"

# Testes de todos os projetos
test:
	@echo "🧪 Executando testes..."
	npm run test
	@echo "✅ Testes concluídos!"

# Lint de todos os projetos
lint:
	@echo "🔍 Executando lint..."
	npm run lint
	@echo "✅ Lint concluído!"

# Fix de lint
lint-fix:
	@echo "🔧 Corrigindo problemas de lint..."
	npm run lint:fix
	@echo "✅ Lint corrigido!"

# Status dos containers
status:
	@echo "📊 Status dos containers:"
	docker-compose ps

# Restart de um serviço específico
restart-api:
	@echo "🔄 Reiniciando API..."
	docker-compose restart api

restart-frontend:
	@echo "🔄 Reiniciando Frontend..."
	docker-compose restart frontend

restart-db:
	@echo "🔄 Reiniciando Banco..."
	docker-compose restart db

# Exibe ajuda
help:
	@echo "🏥 VollMed Monorepo - Comandos disponíveis:"
	@echo ""
	@echo "  🚀 PRINCIPAIS:"
	@echo "    make up           - Inicia toda a aplicação (rápido)"
	@echo "    make up-build     - Inicia com rebuild (quando necessário)"
	@echo "    make down         - Para toda a aplicação"
	@echo "    make logs         - Visualiza logs em tempo real"
	@echo ""
	@echo "  📊 LOGS ESPECÍFICOS:"
	@echo "    make logs-api     - Logs apenas da API"
	@echo "    make logs-frontend - Logs apenas do Frontend"
	@echo "    make logs-db      - Logs apenas do Banco"
	@echo ""
	@echo "  🔧 DESENVOLVIMENTO:"
	@echo "    make install      - Instala dependências"
	@echo "    make dev          - Desenvolvimento local"
	@echo "    make build        - Build de tudo"
	@echo "    make test         - Executa testes"
	@echo "    make lint         - Executa lint"
	@echo ""
	@echo "  🔄 UTILITÁRIOS:"
	@echo "    make clean        - Para e remove dados"
	@echo "    make status       - Status dos containers"
	@echo "    make restart-*    - Reinicia serviço específico"
	@echo ""
	@echo "💡 URLs da aplicação:"
	@echo "   API: http://localhost:3000"
	@echo "   Frontend: http://localhost:3001"
	@echo "   DB: localhost:3306"
	@echo "   Redis: localhost:6379"
