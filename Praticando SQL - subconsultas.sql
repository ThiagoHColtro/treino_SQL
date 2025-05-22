#Obtendo a média salarial de cada departamento
SELECT nomedepartamento, 
	(SELECT AVG(salario) 
     FROM TabelaColaboradores c 
     WHERE d.id_departamento = c.id_departamento) AS MediaSalarial
FROM TabelaDepartamento d

#Levantamento de valores de empréstimo que estejam acima da média 
SELECT nome, valor
FROM TabelaClientes c 
JOIN TabelaEmprestimo e ON e.id_cliente = c.id_cliente
WHERE valor > (SELECT AVG(valor) FROM TabelaEmprestimo)

#Levantamento de cidades com empréstimos ativos 
SELECT cidade, COUNT(*) AS EmprestimosAtivos
FROM TabelaClientes c 
JOIN TabelaEmprestimo e ON e.id_cliente = c.id_cliente
WHERE status = 1
GROUP BY cidade

#Selecionando clientes com pagamentos quitados
SELECT nome, email, e.valor
FROM TabelaClientes c 
JOIN TabelaEmprestimo e ON e.id_cliente = c.id_cliente
JOIN TabelaPagamentos p ON p.id_emprestimo = e.id_emprestimo
WHERE NOT EXISTS (
  SELECT *
  FROM TabelaPagamentos
  WHERE p.Status != 'Pago'
);

#Selecionando clientes com pontuacao acima da média
SELECT nome, s.pontuacao
FROM TabelaClientes c 
JOIN TabelaScoreCredito s ON s.id_cliente = c.id_cliente
WHERE s.pontuacao > (SELECT AVG(pontuacao) FROM TabelaScoreCredito)

#Verificando os maiores salários por departamento
SELECT nomedepartamento, MAX(salario) AS MaiorSalario
FROM TabelaDepartamento d
JOIN TabelaColaboradores c ON c.id_departamento = d.id_departamento
GROUP BY nomedepartamento

#Selecionando apenas clientes com empréstimos ativos
SELECT nome
FROM TabelaClientes c 
JOIN TabelaEmprestimo e ON e.id_cliente = c.id_cliente
WHERE status = 1

#Selecionando a média de valores pagos pelos clientes
SELECT 
    Tipo, 
    (SELECT AVG(Valor) 
     FROM TabelaPagamentos p 
     WHERE p.id_emprestimo = e.id_emprestimo
    AND status = 'Pago') AS MediaPagamentos
FROM TabelaEmprestimo e;

#Demonstrando todos os dados das contas dos clientes
SELECT cl.Nome, numeroconta, tipoconta, saldo
FROM TabelaConta co
JOIN TabelaClienteConta cc ON cc.id_conta = co.id_conta
JOIN TabelaClientes cl ON cl.id_cliente = cc.id_cliente

#Analisando a distribuição de valores totais de empréstimo por cidade
SELECT 
    c.Cidade,
    (SELECT SUM(e.Valor) 
     FROM TabelaEmprestimo e 
     WHERE e.id_cliente IN (
         SELECT cl.id_cliente 
         FROM TabelaClientes cl 
         WHERE cl.Cidade = c.Cidade
     )) AS ValorTotalEmprestimos
FROM TabelaClientes c
GROUP BY c.Cidade;

