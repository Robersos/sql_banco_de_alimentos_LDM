SELECT 
    l.id_Lote,
    l.Numero_Lote,
    p.Nome AS Nome_Produto,
    l.Quantidade AS Saldo_Atual,
    l.Data_validade,
    DATEDIFF(l.Data_validade, CURDATE()) AS Dias_Ate_Vencimento
FROM 
    Lote l
JOIN 
    Produto p ON l.idProduto = p.id_Produto
WHERE 
    l.Quantidade > 0
ORDER BY 
    l.Data_validade ASC;