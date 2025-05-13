SELECT * FROM TabelaClientes

SELECT nomecolaborador, cargo 
FROM TabelaColaboradores

SELECT * 
FROM TabelaEmprestimo
WHERE status = TRUE

SELECT * 
FROM TabelaClientes
WHERE estado = 'SP'

SELECT * 
FROM TabelaColaboradores
WHERE salario > 5000

SELECT * 
FROM TabelaEmprestimo
WHERE valor >= 10000

SELECT nomecolaborador, cargo
FROM TabelaColaboradores
ORDER BY nomecolaborador ASC

SELECT *
FROM TabelaColaboradores
LIMIT 5

SELECT *
FROM TabelaEmprestimo
ORDER BY valor DESC

SELECT *
FROM TabelaColaboradores
WHERE salario >= 5000
ORDER BY id_colaborador DESC
LIMIT 2





