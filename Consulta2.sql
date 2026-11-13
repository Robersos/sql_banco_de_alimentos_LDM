SELECT 
    p.Nome AS Nome_Produto,
    p.Categoria,
    SUM(l.Quantidade) AS Total_Doado_No_Mes
FROM 
    Lote l
JOIN 
    Doacao d ON l.id_Doacao = d.id_Doacao
JOIN 
    Produto p ON l.idProduto = p.id_Produto
WHERE 
    MONTH(d.Data_Recebimento) = MONTH(CURDATE())
    AND YEAR(d.Data_Recebimento) = YEAR(CURDATE())
GROUP BY 
    p.id_Produto, 
    p.Nome, 
    p.Categoria
ORDER BY 
    Total_Doado_No_Mes DESC;