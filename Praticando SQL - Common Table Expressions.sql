#Determinando o valor total de empréstimos pendentes
WITH EmprestimosPendentes AS (
    SELECT Valor
    FROM TabelaEmprestimo
    WHERE Status = 0
)
SELECT SUM(Valor) AS ValoresPendentes
FROM EmprestimosPendentes;

#Selecionando clientes com pontuações acima de 700
WITH ClientesMaiorCredito AS (
    SELECT sc.id_cliente, cl.Nome, sc.Pontuacao
    FROM TabelaScoreCredito sc
    JOIN TabelaClientes cl ON sc.id_cliente = cl.id_cliente
    WHERE sc.Pontuacao > 700
)
SELECT id_cliente, Nome, Pontuacao
FROM ClientesMaiorCredito

#Custo dos salários por Departamento
WITH ClientesMaiorCredito AS (
    SELECT c.id_departamento, SUM(salario) AS TotalSalarios, d.NomeDepartamento
    FROM TabelaColaboradores c
    JOIN TabelaDepartamento d ON d.id_departamento = c.id_departamento
  	GROUP BY nomedepartamento
)
SELECT id_departamento, nomedepartamento, TotalSalarios
FROM ClientesMaiorCredito

#Verificando a quantidade de clientes por Estado
WITH ClientesPorEstado AS (
    SELECT estado, COUNT(estado) AS QuantidadeClientes
    FROM TabelaClientes
  	GROUP BY estado
)
SELECT estado, QuantidadeClientes
FROM ClientesPorEstado

#Buscando clientes com idade inferior à média de idade dos clientes
WITH IdadesClientes AS (
    SELECT Nome, strftime('%Y', 'now') - strftime('%Y', DataNascimento) AS Idade
    FROM TabelaClientes
),
MediaIdade AS (
    SELECT AVG(Idade) AS IdadeMedia
    FROM IdadesClientes
)
SELECT ic.Nome, ic.Idade
FROM IdadesClientes ic
CROSS JOIN MediaIdade mi
WHERE ic.Idade < mi.IdadeMedia;

#Identificando clientes com mais de uma conta
WITH ClientesMultiplasContas AS (
    SELECT id_cliente
    FROM TabelaClienteConta
    GROUP BY id_cliente
    HAVING COUNT(id_conta) > 1
),
EmprestimosClientesMultiplasContas AS (
    SELECT e.id_emprestimo, e.id_cliente, e.Valor
    FROM TabelaEmprestimo e
    WHERE e.id_cliente IN (SELECT id_cliente FROM ClientesMultiplasContas)
)
SELECT id_emprestimo, id_cliente, Valor
FROM EmprestimosClientesMultiplasContas;

#Filtrando empréstimos que já obtiveram pagamentos acima de R$ 1.000,00
WITH PagamentosPorEmprestimo AS (
    SELECT id_emprestimo, SUM(Valor) AS TotalPagamentos
    FROM TabelaPagamentos
    GROUP BY id_emprestimo
),
EmprestimosComPagamentosAltos AS (
    SELECT id_emprestimo, TotalPagamentos
    FROM PagamentosPorEmprestimo
    WHERE TotalPagamentos >= 1000
)
SELECT ep.id_emprestimo, ep.TotalPagamentos
FROM EmprestimosComPagamentosAltos ep;

#Identificando departamentos com salários médio acima de R$ 4.500,00
WITH MediaSalariosPorDepartamento AS (
    SELECT id_departamento, AVG(Salario) AS MediaSalarial
    FROM TabelaColaboradores
    GROUP BY id_departamento
),
DepartamentosComSalarioAlto AS (
    SELECT id_departamento, MediaSalarial
    FROM MediaSalariosPorDepartamento
    WHERE MediaSalarial > 4500
)
SELECT id_departamento, MediaSalarial
FROM DepartamentosComSalarioAlto;

#Identificando clientes de alto risco, com pendências e baixo score 
WITH ClientesPendentes AS (
  SELECT c.Nome, status, valor, sc.Pontuacao
  FROM TabelaEmprestimo e
  JOIN TabelaClientes c ON c.id_cliente = e.id_cliente
  JOIN TabelaScoreCredito sc ON sc.id_cliente = e.id_cliente
  GROUP BY c.Nome
  HAVING e.Status = 0
)
SELECT cp.nome 
FROM ClientesPendentes cp
WHERE pontuacao < 500
#Alternativamente, fazendo duas CTEs
WITH ClientesComEmprestimosPendentes AS (
    SELECT id_cliente
    FROM TabelaEmprestimo
    WHERE Status = 0
),
ClientesComCreditoBaixo AS (
    SELECT id_cliente
    FROM TabelaScoreCredito
    WHERE Pontuacao < 500
)
SELECT cl.Nome
FROM ClientesComEmprestimosPendentes ce
JOIN ClientesComCreditoBaixo cb ON ce.id_cliente = cb.id_cliente
JOIN TabelaClientes cl ON ce.id_cliente = cl.id_cliente;

#Total e saldo de contas aberta após 01-01-2023
WITH ContasNovas AS (
  SELECT dataabertura, id_conta, saldo
  FROM TabelaConta
  WHERE dataabertura > '2023-01-01'), 
  ContagemContas AS (
    SELECT COUNT(id_conta) AS TotalContas, AVG(Saldo) AS MediaSaldos
    FROM ContasNovas)
SELECT * FROM ContagemContas
