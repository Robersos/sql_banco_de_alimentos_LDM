SELECT 
    b.id_Beneficiario,
    b.Nome AS Nome_Beneficiario,
    COUNT(p.id_Pedido) AS Total_Pedidos,
    SUM(p.Quantidade_Solicitada) AS Total_Itens_Solicitados
FROM 
    Beneficiario b
JOIN 
    Pedido p ON b.id_Beneficiario = p.id_Beneficiario
WHERE 
    p.Data_Pedido >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY 
    b.id_Beneficiario, 
    b.Nome
ORDER BY 
    Total_Pedidos DESC;