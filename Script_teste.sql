-- =====================================================================
-- 1. CADASTRO DE DOADORES
-- =====================================================================
INSERT INTO Doador (id_doador, Nome, Documento, Contato) VALUES 
(1, 'Empresa Alimentos S.A.', '12.345.678/0001-99', 'contato@alimentos.com'),
(2, 'Supermercado Bom Preço', '98.765.432/0001-11', 'doacoes@bompreco.com');


-- =====================================================================
-- 2. CADASTRO DE DOAÇÕES (Vinculadas aos Doadores)
-- =====================================================================
INSERT INTO Doacao (id_Doacao, Data_Recebimento, tipo_Entrada, id_Doador) VALUES 
(101, '2026-06-01', 'Alimentos não perecíveis', 1),
(102, '2026-06-05', 'Hortifrúti', 2);


-- =====================================================================
-- 3. CADASTRO DE PRODUTOS (Catálogo geral independente)
-- =====================================================================
INSERT INTO Produto (id_Produto, Nome, Categoria, Unidade_Medida) VALUES 
(201, 'Arroz Tipo 1', 'Alimentos', 'Quilo'),
(202, 'Feijão Carioca', 'Alimentos', 'Quilo'),
(203, 'Leite Integral', 'Bebidas', 'Litro');


-- =====================================================================
-- 4. CADASTRO DE LOTES (A ponte entre Doação e Produto)
-- =====================================================================
INSERT INTO Lote (id_Lote, Numero_Lote, Data_validade, Quantidade, id_Doacao, idProduto) VALUES 
(301, 'LOTE-ARROZ-001', '2027-12-31', 100, 101, 201), -- 100 kg de Arroz
(302, 'LOTE-FEIJAO-001', '2027-06-30', 50, 101, 202),  -- 50 kg de Feijão
(303, 'LOTE-LEITE-001', '2026-07-15', 30, 102, 203);   -- 30 litros de Leite


-- =====================================================================
-- 5. CADASTRO DE BENEFICIÁRIOS
-- =====================================================================
INSERT INTO Beneficiario (id_Beneficiario, Nome, Documento, Endereco, Contato) VALUES 
(401, 'Associação Comunitária Esperança', '111.222.333-44', 'Rua das Flores, 123', '(43) 99999-1111'),
(402, 'Creche Lar das Crianças', '555.666.777-88', 'Av. Central, 456', '(43) 98888-2222');


-- =====================================================================
-- 6. CADASTRO DE PEDIDOS / DISTRIBUIÇÃO (Vinculado a Beneficiários)
-- =====================================================================
INSERT INTO Pedido (id_Pedido, Data_Pedido, Quantidade_Solicitada, Status_Pedido, id_Beneficiario) VALUES 
(501, '2026-06-07', 20, 'Entregue', 401),
(502, '2026-06-08', 15, 'Pendente', 402);


-- =====================================================================
-- 7. REGISTRO DE PERDAS (Dispara o Trigger de atualização de estoque)
-- =====================================================================
-- Registra a perda de 5 unidades do Lote 301 (Arroz). 
-- O Trigger irá abater automaticamente 5 do estoque do Lote 301 (baixando de 100 para 95).
INSERT INTO Perda (id_Perda, Categoria_Perda, Justificativa, Quantidade, idLote) VALUES 
(601, 'Avaria', 'Embalagens rasgadas durante o transporte interno', 5, 301);