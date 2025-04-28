SELECT 
    c.nome,
    AVG(l.kwh) AS media_kwh
FROM clientes c
JOIN contratos ct ON c.id = ct.cliente_id
JOIN leituras l ON ct.id = l.contrato_id
WHERE ct.ativo = true
  AND l.data_leitura >= (CURRENT_DATE - INTERVAL '3 months')
GROUP BY c.nome;
