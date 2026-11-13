-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 12/11/2026 às 00:08
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `banco_de_alimentos_ldm`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamento`
--

CREATE TABLE `agendamento` (
  `id_agendamento` int(11) NOT NULL,
  `Tipo_Operacao` varchar(255) DEFAULT NULL,
  `Date_Hora` datetime DEFAULT NULL,
  `Responsavel` varchar(255) DEFAULT NULL,
  `Status_transporte` varchar(255) DEFAULT NULL,
  `id_Pedido` int(11) NOT NULL,
  `id_Beneficiario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `beneficiario`
--

CREATE TABLE `beneficiario` (
  `id_Beneficiario` int(11) NOT NULL,
  `Nome_Entidade` varchar(255) DEFAULT NULL,
  `Documento_Unico` varchar(255) DEFAULT NULL,
  `Capacidade_Armazenamento` varchar(255) DEFAULT NULL,
  `Prioridade` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `doacao`
--

CREATE TABLE `doacao` (
  `id_Doacao` int(11) NOT NULL,
  `Data_Recebimento` date DEFAULT NULL,
  `tipo_Entrada` varchar(255) DEFAULT NULL,
  `id_Doador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `doacao`
--

INSERT INTO `doacao` (`id_Doacao`, `Data_Recebimento`, `tipo_Entrada`, `id_Doador`) VALUES
(777, '2026-06-06', 'Alimentos', 777),
(888, '2026-06-06', 'Roupas', 888);

-- --------------------------------------------------------

--
-- Estrutura para tabela `doador`
--

CREATE TABLE `doador` (
  `id_doador` int(11) NOT NULL,
  `Nome` varchar(255) DEFAULT NULL,
  `Documento` varchar(255) DEFAULT NULL,
  `Contato` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `doador`
--

INSERT INTO `doador` (`id_doador`, `Nome`, `Documento`, `Contato`) VALUES
(777, 'Supermercado Solidário', '111222333', 'contato@mercado.com'),
(888, 'Doador Teste Trigger', '999999999', 'teste@trigger.com');

-- --------------------------------------------------------

--
-- Estrutura para tabela `lote`
--

CREATE TABLE `lote` (
  `id_Lote` int(11) NOT NULL,
  `Numero_Lote` varchar(255) DEFAULT NULL,
  `Data_validade` date DEFAULT NULL,
  `Quantidade` int(11) DEFAULT NULL,
  `id_Doacao` int(11) NOT NULL,
  `idProduto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `lote`
--

INSERT INTO `lote` (`id_Lote`, `Numero_Lote`, `Data_validade`, `Quantidade`, `id_Doacao`, `idProduto`) VALUES
(888, 'LOTE-TESTE-01', '2027-12-31', 40, 888, 888),
(901, 'LOT-ARROZ-01', '2027-01-01', 25, 777, 701),
(902, 'LOT-ARROZ-02', '2027-06-01', 20, 777, 701),
(903, 'LOT-FEIJAO-01', '2027-03-01', 40, 777, 702);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido`
--

CREATE TABLE `pedido` (
  `id_Pedido` int(11) NOT NULL,
  `Data_Pedido` date DEFAULT NULL,
  `Status` varchar(255) DEFAULT NULL,
  `id_Beneficiario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido_lote`
--

CREATE TABLE `pedido_lote` (
  `id_Lote` int(11) NOT NULL,
  `Quantidade_Atendida` int(11) DEFAULT NULL,
  `idPedido` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `perda`
--

CREATE TABLE `perda` (
  `id_Perda` int(11) NOT NULL,
  `Categoria_Perda` varchar(255) DEFAULT NULL,
  `Justificativa` varchar(255) DEFAULT NULL,
  `Quantidade` int(11) DEFAULT NULL,
  `idLote` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `perda`
--

INSERT INTO `perda` (`id_Perda`, `Categoria_Perda`, `Justificativa`, `Quantidade`, `idLote`) VALUES
(501, 'Avaria', 'Embalagens rasgadas', 5, 901),
(888, 'Avaria', 'Peças danificadas', 10, 888);

--
-- Acionadores `perda`
--
DELIMITER $$
CREATE TRIGGER `trg_atualiza_quantidade_lote` AFTER INSERT ON `perda` FOR EACH ROW BEGIN
    -- Atualiza o Lote subtraindo a quantidade que foi perdida
    UPDATE Lote
    SET Quantidade = Quantidade - NEW.Quantidade
    WHERE id_Lote = NEW.idLote;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto`
--

CREATE TABLE `produto` (
  `id_Produto` int(11) NOT NULL,
  `Nome` varchar(255) DEFAULT NULL,
  `Categoria` varchar(255) DEFAULT NULL,
  `Unidade_Medida` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produto`
--

INSERT INTO `produto` (`id_Produto`, `Nome`, `Categoria`, `Unidade_Medida`) VALUES
(701, 'Arroz 5kg', 'Alimentos', 'Pacote'),
(702, 'Feijão 1kg', 'Alimentos', 'Pacote'),
(703, 'Óleo de Soja', 'Alimentos', 'Unidade'),
(888, 'Casaco', 'Vestuário', 'Unidade');

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_quantidade_total_produtos`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_quantidade_total_produtos` (
`id_Produto` int(11)
,`Nome_Produto` varchar(255)
,`Categoria` varchar(255)
,`Unidade_Medida` varchar(255)
,`Quantidade_Total` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Estrutura para view `vw_quantidade_total_produtos`
--
DROP TABLE IF EXISTS `vw_quantidade_total_produtos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_quantidade_total_produtos`  AS SELECT `p`.`id_Produto` AS `id_Produto`, `p`.`Nome` AS `Nome_Produto`, `p`.`Categoria` AS `Categoria`, `p`.`Unidade_Medida` AS `Unidade_Medida`, coalesce(sum(`l`.`Quantidade`),0) AS `Quantidade_Total` FROM (`produto` `p` left join `lote` `l` on(`p`.`id_Produto` = `l`.`idProduto`)) GROUP BY `p`.`id_Produto`, `p`.`Nome`, `p`.`Categoria`, `p`.`Unidade_Medida` ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `agendamento`
--
ALTER TABLE `agendamento`
  ADD PRIMARY KEY (`id_agendamento`),
  ADD KEY `fk_agendamento_pedido` (`id_Pedido`),
  ADD KEY `fk_agendamento_beneficiario` (`id_Beneficiario`);

--
-- Índices de tabela `beneficiario`
--
ALTER TABLE `beneficiario`
  ADD PRIMARY KEY (`id_Beneficiario`),
  ADD UNIQUE KEY `uk_beneficiario_documento` (`Documento_Unico`);

--
-- Índices de tabela `doacao`
--
ALTER TABLE `doacao`
  ADD PRIMARY KEY (`id_Doacao`),
  ADD KEY `fk_doacao_doador` (`id_Doador`);

--
-- Índices de tabela `doador`
--
ALTER TABLE `doador`
  ADD PRIMARY KEY (`id_doador`);

--
-- Índices de tabela `lote`
--
ALTER TABLE `lote`
  ADD PRIMARY KEY (`id_Lote`),
  ADD UNIQUE KEY `uk_lote_numero` (`Numero_Lote`),
  ADD KEY `fk_lote_doacao` (`id_Doacao`),
  ADD KEY `fk_lote_produto` (`idProduto`);

--
-- Índices de tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_Pedido`),
  ADD KEY `fk_pedido_beneficiario` (`id_Beneficiario`);

--
-- Índices de tabela `pedido_lote`
--
ALTER TABLE `pedido_lote`
  ADD PRIMARY KEY (`id_Lote`,`idPedido`),
  ADD KEY `fk_pedidolote_pedido` (`idPedido`);

--
-- Índices de tabela `perda`
--
ALTER TABLE `perda`
  ADD PRIMARY KEY (`id_Perda`),
  ADD KEY `fk_perda_lote` (`idLote`);

--
-- Índices de tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id_Produto`);

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `agendamento`
--
ALTER TABLE `agendamento`
  ADD CONSTRAINT `fk_agendamento_beneficiario` FOREIGN KEY (`id_Beneficiario`) REFERENCES `beneficiario` (`id_Beneficiario`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_agendamento_pedido` FOREIGN KEY (`id_Pedido`) REFERENCES `pedido` (`id_Pedido`) ON DELETE CASCADE;

--
-- Restrições para tabelas `doacao`
--
ALTER TABLE `doacao`
  ADD CONSTRAINT `fk_doacao_doador` FOREIGN KEY (`id_Doador`) REFERENCES `doador` (`id_doador`) ON DELETE CASCADE;

--
-- Restrições para tabelas `lote`
--
ALTER TABLE `lote`
  ADD CONSTRAINT `fk_lote_doacao` FOREIGN KEY (`id_Doacao`) REFERENCES `doacao` (`id_Doacao`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_lote_produto` FOREIGN KEY (`idProduto`) REFERENCES `produto` (`id_Produto`) ON DELETE CASCADE;

--
-- Restrições para tabelas `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_pedido_beneficiario` FOREIGN KEY (`id_Beneficiario`) REFERENCES `beneficiario` (`id_Beneficiario`) ON DELETE CASCADE;

--
-- Restrições para tabelas `pedido_lote`
--
ALTER TABLE `pedido_lote`
  ADD CONSTRAINT `fk_pedidolote_lote` FOREIGN KEY (`id_Lote`) REFERENCES `lote` (`id_Lote`),
  ADD CONSTRAINT `fk_pedidolote_pedido` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`id_Pedido`);

--
-- Restrições para tabelas `perda`
--
ALTER TABLE `perda`
  ADD CONSTRAINT `fk_perda_lote` FOREIGN KEY (`idLote`) REFERENCES `lote` (`id_Lote`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
