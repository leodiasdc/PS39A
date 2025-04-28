-- Tabela de clientes
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

-- Tabela de contratos
CREATE TABLE contratos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL REFERENCES clientes(id),
    data_inicio DATE NOT NULL,
    ativo BOOLEAN DEFAULT true
);

-- Tabela de leituras energéticas
CREATE TABLE leituras (
    id SERIAL PRIMARY KEY,
    contrato_id INTEGER NOT NULL REFERENCES contratos(id),
    data_leitura DATE NOT NULL,
    kwh DECIMAL(10, 2) NOT NULL
);

-- Justificativas:
-- SERIAL para IDs para facilitar autoincremento.
-- Uso de chaves estrangeiras para garantir integridade relacional.
-- Booleano para status de contrato, pois facilita consulta de ativos.
-- Decimal no consumo para permitir valores fracionados (kWh).

-- Inserção de dados fictícios
INSERT INTO clientes (nome) VALUES 
('Cliente A'), ('Cliente B'), ('Cliente C'), ('Cliente D'), ('Cliente E');

-- Contratos
INSERT INTO contratos (cliente_id, data_inicio, ativo) VALUES 
(1, '2023-01-01', true),
(2, '2023-01-01', true),
(2, '2024-01-01', true), -- Cliente B com 2 contratos
(3, '2023-06-01', false),
(3, '2024-01-01', true), -- Cliente C com 2 contratos
(4, '2023-03-01', true),
(5, '2023-05-01', true);

-- Leituras dos últimos 3 meses
-- Exemplo simplificado
INSERT INTO leituras (contrato_id, data_leitura, kwh) VALUES
(1, '2025-02-01', 300), (1, '2025-03-01', 320), (1, '2025-04-01', 310),
(2, '2025-02-01', 200), (2, '2025-03-01', 220), (2, '2025-04-01', 210),
(3, '2025-02-01', 400), (3, '2025-03-01', 450), (3, '2025-04-01', 420),
(5, '2025-02-01', 100), (5, '2025-03-01', 110), (5, '2025-04-01', 105),
(6, '2025-02-01', 500), (6, '2025-03-01', 550), (6, '2025-04-01', 530),
(7, '2025-02-01', 250), (7, '2025-03-01', 260), (7, '2025-04-01', 255);
