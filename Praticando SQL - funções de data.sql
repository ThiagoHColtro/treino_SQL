#Hora e data atual
SELECT CURRENT_TIMESTAMP AS DataHoraAtual

#Data de nascimento formatada YYYY-MM-DD
SELECT Nome, STRFTIME('%Y-%m-%d', DataNascimento) AS Data_Formatada 
FROM TabelaClientes

#Cálculo de dias totais até o final do empréstimo
SELECT id_emprestimo, 
       JULIANDAY(DATE(DataInicio, '+' || Prazo || ' days')) - JULIANDAY(DataInicio) AS DiasTotais
FROM TabelaEmprestimo;

#Nome e Ano de nascimento
SELECT nome, STRFTIME('%Y', datanascimento) AS Ano
FROM TabelaClientes

#Empréstimos realizados entre 2023-01-01 e 2023-03-31
SELECT *
FROM TabelaEmprestimo
WHERE datainicio BETWEEN '2023-01-01' AND '2023-03-31'

#Calcula a data de vencimento somando os dias do prazo
SELECT id_emprestimo, 
       DataInicio, 
       DATE(DataInicio, '+' || Prazo || ' days') AS DataVencimento 
FROM TabelaEmprestimo;

#Ordenando os pagamentos em ordem crescente
SELECT *
FROM TabelaPagamentos
ORDER BY datapagamento ASC

#Calculando a idade dos clientes
SELECT Nome, 
       (strftime('%Y', 'now') - strftime('%Y', DataNascimento)) - 
       (strftime('%m-%d', 'now') < strftime('%m-%d', DataNascimento)) AS Idade
FROM TabelaClientes;

#Calculando o prazo dos empréstimos e determinando seu status como "vencido" ou "no prazo"
SELECT id_emprestimo, 
       CASE 
           WHEN STRFTIME('%Y-%m-%d', DATE(DataInicio, '+' || Prazo || ' days')) < STRFTIME('%Y-%m-%d', 'now') THEN 'Vencido'
           ELSE 'No Prazo'
       END AS StatusEmprestimo
FROM TabelaEmprestimo;
#Alternativamente:
SELECT id_emprestimo, 
       CASE 
           WHEN JULIANDAY(DATE(DataInicio, '+' || Prazo || ' days')) < JULIANDAY('now') THEN 'Vencido'
           ELSE 'No Prazo'
       END AS StatusEmprestimo
FROM TabelaEmprestimo;

#Calculando a data do próximo pagamento a partir da data de início
SELECT id_emprestimo, datainicio, DATE(DataInicio, '+30 days') AS ProximoPagamento
FROM TabelaEmprestimo;
