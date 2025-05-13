
SELECT nomecolaborador, salario, id_departamento
FROM TabelaColaboradores
WHERE salario > 4500 AND id_departamento = 'D03'

SELECT nome, datanascimento, estado
FROM TabelaClientes
WHERE datanascimento < '1990-01-01' OR estado = 'SP'

SELECT *
FROM TabelaEmprestimo
WHERE datainicio BETWEEN '01/01/2023' AND '31/12/2023'

SELECT Nome, DataNascimento, CPF
FROM TabelaClientes
WHERE strftime('%Y', 'now') - strftime('%Y', DataNascimento) >= 18

SELECT id_emprestimo, Tipo, Valor
FROM TabelaEmprestimo
WHERE TRIM(tipo) IN ('Pessoal', 'Imobiliário');

SELECT id_emprestimo, valor, tipo
FROM TabelaEmprestimo
WHERE valor BETWEEN 10000 AND 50000 AND TRIM(tipo) IN ('Consignado', 'Automóvel')

SELECT DISTINCT Estado
FROM TabelaClientes;

SELECT nome, CPF, cidade, estado
FROM TabelaClientes
WHERE CPF LIKE '6%' AND (cidade = 'Rio de Janeiro' OR cidade = 'Salvador')

SELECT *
FROM TabelaPagamentos
WHERE valor BETWEEN 500 AND 1000 AND datapagamento LIKE '2023%'

SELECT sc.id_cliente, c.nome, sc.Pontuacao, sc.fonte
FROM TabelaScoreCredito sc
JOIN TabelaClientes c ON c.id_cliente = sc.id_cliente
WHERE sc.pontuacao < 700

