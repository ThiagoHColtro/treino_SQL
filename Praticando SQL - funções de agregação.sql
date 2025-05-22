#Calculando o valor total de empréstimos
SELECT SUM(valor) AS Total_Empréstimo
FROM TabelaEmprestimo

#Calculando a média salarial dos colaboradores
SELECT AVG(Salario) as MediaSalarial
FROM TabelaColaboradores

#Obtendo o maior valor de empréstimo
SELECT MAX(Valor) AS MaiorEmprestimo
FROM TabelaEmprestimo

#Obtendo o menor valor de empréstimo
SELECT MIN(Valor) AS MaiorEmprestimo
FROM TabelaEmprestimo

#Obtendo a quantidade de colaboradores ativos
SELECT COUNT(*) AS Colaboradores
FROM TabelaColaboradores

#Obtendo a médio dos valores de empréstimos concedidos
SELECT SUM(Valor)/COUNT(*) AS MediaEmprestimos
FROM TabelaEmprestimo

#Total do valor de salários por departamento
SELECT id_departamento, SUM(Salario) AS TotalSalarios
FROM TabelaColaboradores
GROUP BY id_departamento

#Obtendo categorias com total de empréstimos superior a 20.000
SELECT Tipo, SUM(Valor) AS MaioresEmprestimos
FROM TabelaEmprestimo
GROUP BY Tipo
HAVING MaioresEmprestimos > 20000

#Somando a quantidade de empréstimos por categoria
SELECT Tipo, COUNT(Tipo) AS QuantidadeEmprestimos, SUM(Valor) AS TotalEmprestimo
FROM TabelaEmprestimo
GROUP BY Tipo

#Valores dos empréstimos consolidados
SELECT SUM(valor) AS TotalEmprestimos, 
AVG(valor) AS MediaEmprestimos, 
MAX(valor) AS MaiorEmprestimo, 
MIN(valor) AS MenorEmprestimo
FROM TabelaEmprestimo