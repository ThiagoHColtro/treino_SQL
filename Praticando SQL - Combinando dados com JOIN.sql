#Correlacionando colabores e seus respectivos departamentos
SELECT nomecolaborador, d.NomeDepartamento
FROM TabelaColaboradores c
JOIN TabelaDepartamento d ON d.id_departamento = c.id_departamento

#Levantamento de todos os telefones cadastrados para os clientes
SELECT c.id_cliente, nome, t.Telefone
FROM TabelaClientes c
LEFT JOIN TabelaTelefones t ON t.id_cliente = c.id_cliente

#Correlacionando colaboradores e respectivos clientes
SELECT co.nomecolaborador, nome
FROM TabelaClientes cl
RIGHT JOIN TabelaColaboradores co ON co.id_colaborador = cl.id_colaborador

#Levantamento de todos os empréstimos com ou sem clientes correlacionados 
SELECT nome, e.Tipo, e.Valor
FROM TabelaClientes c
FULL JOIN TabelaEmprestimo e ON e.id_cliente = c.id_cliente

#Demonstrativo de clientes, seus empréstimos e pagamentos
SELECT nome, e.Tipo, e.Valor, p.DataPagamento, p.Valor
FROM TabelaClientes c
INNER JOIN TabelaEmprestimo e ON e.id_cliente = c.id_cliente
INNER JOIN TabelaPagamentos p ON p.id_emprestimo = e.id_emprestimo

#Demonstrativo de clientes de alto valor em empréstimos agregados
SELECT nome, e.Valor
FROM TabelaClientes c
JOIN TabelaEmprestimo e ON e.id_cliente = c.id_cliente
GROUP BY c.Nome
HAVING SUM(e.valor) > 10000

#Levantamento de empréstimos, se todos tem cliente atribuído
SELECT e.Tipo, e.Valor,
    CASE 
        WHEN e.Status THEN 'Ativo'
        ELSE 'Inativo'
    END AS Status
FROM TabelaClientes c
RIGHT JOIN TabelaEmprestimo e ON c.id_cliente = e.id_cliente
WHERE c.id_cliente IS NOT NULL;

#Correlacionando informações acerca de clientes de São Paulo
SELECT nome  AS NomeCliente, cidade, co.NomeColaborador, d.NomeDepartamento
FROM TabelaClientes cl
INNER JOIN TabelaColaboradores co ON co.id_colaborador = cl.id_colaborador
INNER JOIN TabelaDepartamento d ON d.id_departamento = co.id_departamento
GROUP BY cidade
HAVING cidade = 'São Paulo'

#Selecionando clientes com valores de empréstimos acima da média
SELECT nome, e.Valor
FROM TabelaClientes c
JOIN TabelaEmprestimo e ON e.id_cliente = c.id_cliente
WHERE e.Valor > (SELECT AVG(valor) FROM TabelaEmprestimo);

#Detalhando colaboradores, seus departamentos e e-mails
SELECT nomecolaborador, d.NomeDepartamento, emailcolaborador
FROM TabelaColaboradores co
FULL JOIN TabelaDepartamento d ON d.id_departamento = co.id_departamento
#Alternativamente poderia ser utilizado a função COALESCE
SELECT 
    COALESCE(c.NomeColaborador, 'Sem Colaborador') AS NomeColaborador,
    COALESCE(d.NomeDepartamento, 'Sem Departamento') AS NomeDepartamento,
    COALESCE(c.EmailColaborador, 'Não informado') AS Email
FROM 
    TabelaColaboradores c
FULL JOIN 
    TabelaDepartamento d 
ON 
    c.id_departamento = d.id_departamento;