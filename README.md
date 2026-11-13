# 🗄️ Banco de Dados — Banco de Alimentos de Londrina

Repositório referente à modelagem e implementação do Banco de Dados do sistema de gestão de doações, estoque por lote/validade e distribuição (AEP 2026.2 — Engenharia de Software, 4º Semestre)[cite: 3].

---

## 📌 Objetivo
Estruturar a base de dados relacional para digitalizar o controle de doações, rastrear validades por lote, automatizar o abate de estoque e gerar indicadores operacionais[cite: 3].

---

## 📂 Estrutura do Repositório

* `banco_de_alimentos_ldm.sql` — Script principal contendo a criação das tabelas (DDL), chaves primárias/estrangeiras (`ON DELETE CASCADE`), restrições (`UNIQUE`, `CHECK`), **Triggers** e **Views**[cite: 3, 4].
* `Script_teste.sql` — Massa de dados mínimos e coerentes (DML) para popular o banco e validar as regras de negócio[cite: 3, 4].
* `Consulta1.sql` — Consulta de negócio (ex.: saldo por lote e dias até o vencimento)[cite: 3, 4].
* `Consulta2.sql` — Consulta de negócio (ex.: alimentos mais doados no mês)[cite: 3, 4].
* `Consulta3.sql` — Consulta de negócio (ex.: distribuição/pedidos por instituição no trimestre)[cite: 3, 4].

---

## ⚙️ Objetos Implementados

* **Modelagem Relacional (3FN):** Separação entre o catálogo geral (`Produto`), entradas (`Doacao`) e o controle físico centralizado (`Lote`)[cite: 3].
* **Trigger (`trg_atualiza_quantidade_lote`):** Abate automaticamente a quantidade do lote sempre que uma `Perda` é registrada.
* **View (`vw_quantidade_total_produtos`):** Exibe o saldo total consolidado em estoque por produto.

---

## 🚀 Como Executar

1. Execute o script `banco_de_alimentos_ldm.sql` no **MySQL** para criar o banco, as tabelas, o trigger e a view[cite: 4].
2. Execute o `Script_teste.sql` para inserir os dados de teste e validar o abate automático de estoque[cite: 4].
3. Rode os ficheiros `Consulta1.sql`, `Consulta2.sql` e `Consulta3.sql` para visualizar os relatórios gerenciais[cite: 4].

---

## 🛠️ Tecnologias
* **SGBD:** MySQL / MariaDB
* **Linguagem:** SQL (DDL, DML, DQL)