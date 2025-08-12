-- Script de população que não apaga dados existentes
CREATE DATABASE IF NOT EXISTS testemed;
USE testemed;

-- Criar tabela endereco se não existir
CREATE TABLE IF NOT EXISTS endereco (
    id VARCHAR(36) PRIMARY KEY,
    cep INT NOT NULL,
    rua VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    estado VARCHAR(255) NOT NULL,
    complemento VARCHAR(100)
);

-- Criar tabela imagem se não existir
CREATE TABLE IF NOT EXISTS imagem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tamanho INT NOT NULL,
    url VARCHAR(255) NOT NULL,
    `key` VARCHAR(255) NOT NULL
);

-- Criar tabela clinica se não existir
CREATE TABLE IF NOT EXISTS clinica (
    id VARCHAR(36) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    planoDeSaudeAceitos TEXT,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'CLINICA',
    enderecoId VARCHAR(36),
    FOREIGN KEY (enderecoId) REFERENCES endereco(id)
);

-- Criar tabela especialista se não existir
CREATE TABLE IF NOT EXISTS especialista (
    id VARCHAR(36) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(100) NOT NULL,
    imagem VARCHAR(255),
    estaAtivo BOOLEAN DEFAULT TRUE,
    especialidade VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    senha VARCHAR(100) NOT NULL,
    telefone VARCHAR(255),
    possuiPlanoSaude BOOLEAN DEFAULT TRUE,
    planosSaude TEXT,
    role VARCHAR(50) NOT NULL DEFAULT 'ESPECIALISTA',
    enderecoId VARCHAR(36),
    clinicaId VARCHAR(36),
    FOREIGN KEY (enderecoId) REFERENCES endereco(id),
    FOREIGN KEY (clinicaId) REFERENCES clinica(id)
);

-- Criar tabela paciente se não existir
CREATE TABLE IF NOT EXISTS paciente (
    id VARCHAR(36) PRIMARY KEY,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    estaAtivo BOOLEAN NOT NULL,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    possuiPlanoSaude BOOLEAN NOT NULL,
    planosSaude TEXT,
    historico TEXT,
    imagemUrl TEXT,
    role VARCHAR(50) NOT NULL,
    enderecoId VARCHAR(36),
    imagemId INT,
    FOREIGN KEY (enderecoId) REFERENCES endereco(id),
    FOREIGN KEY (imagemId) REFERENCES imagem(id)
);

-- Criar tabela consulta se não existir
CREATE TABLE IF NOT EXISTS consulta (
    id VARCHAR(36) PRIMARY KEY,
    data DATETIME,
    observacoes TEXT,
    lembrete ENUM('email', 'sms'),
    motivoCancelamento ENUM('paciente_desistiu', 'médico_cancelou', 'outros'),
    estaAtiva BOOLEAN DEFAULT TRUE,
    especialistaId VARCHAR(36),
    pacienteId VARCHAR(36),
    FOREIGN KEY (especialistaId) REFERENCES especialista(id),
    FOREIGN KEY (pacienteId) REFERENCES paciente(id)
);

-- Criar tabela avaliacoes se não existir
CREATE TABLE IF NOT EXISTS avaliacoes (
    id VARCHAR(36) PRIMARY KEY,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nota INT NOT NULL,
    descricao TEXT,
    especialistaId VARCHAR(36),
    pacienteId VARCHAR(36),
    FOREIGN KEY (especialistaId) REFERENCES especialista(id),
    FOREIGN KEY (pacienteId) REFERENCES paciente(id)
);

-- Inserir dados apenas se a tabela paciente estiver vazia
INSERT IGNORE INTO paciente (id, cpf, nome, email, estaAtivo, senha, telefone, possuiPlanoSaude, planosSaude, historico, imagemUrl, role, enderecoId, imagemId)
SELECT * FROM (
    SELECT 
        uuid() as id,
        '78160552009' as cpf,
        'Emerson Laranja' as nome,
        'emerson@email.com' as email,
        true as estaAtivo,
        'Senh@forte123' as senha,
        '34999335522' as telefone,
        true as possuiPlanoSaude,
        '[2]' as planosSaude,
        "['sinusite,moderado']" as historico,
        'https://img.freepik.com/fotos-gratis/designer-trabalhando-no-modelo-3d_23-2149371896.jpg' as imagemUrl,
        'PACIENTE' as role,
        NULL as enderecoId,
        NULL as imagemId
    UNION ALL
    SELECT 
        uuid() as id,
        '12345678901' as cpf,
        'Joana Silva' as nome,
        'joana@email.com' as email,
        true as estaAtivo,
        'MinhaSenha123' as senha,
        '34999887766' as telefone,
        true as possuiPlanoSaude,
        '[1, 3]' as planosSaude,
        "['rinite,leve', 'asma,médio']" as historico,
        'https://img.freepik.com/fotos-premium/retrato-de-uma-jovem-brasileira-sorridente-em-um-vestido-mexicano-ai-gerado_632984-139.jpg' as imagemUrl,
        'PACIENTE' as role,
        NULL as enderecoId,
        NULL as imagemId
) tmp
WHERE NOT EXISTS (SELECT 1 FROM paciente LIMIT 1);
