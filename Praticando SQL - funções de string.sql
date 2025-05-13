#Padronizando nome em maiúsculo
SELECT upper(nome) AS nome_maiusculo
FROM TabelaClientes

#Padronizando nome em minúsculo
SELECT lower(nome) AS nome_minusculo
FROM TabelaClientes

#Criando senha com 3 primeiros dígitos do nome e CPF
SELECT CONCAT(substr(nome, 1, 3), substr(CPF, 1, 3)) AS Código_Identificador
FROM TabelaClientes

#Nome e comprimento do nome
SELECT nome, Length(nome) AS comprimento
FROM TabelaClientes

#Agregando colunas
SELECT CONCAT(nomecolaborador, ' - ', cargo) AS Nome_Cargo
From TabelaColaboradores

#Alterando o nome do departamento para RH
SELECT REPLACE(nomedepartamento, 'Recursos Humanos', 'RH') as NomeDepartamento
FROM TabelaDepartamento

#Apresentação de 3 colunas agrupadas para melhor visualização
SELECT CONCAT(tipo, ' - ', status, ' - $' , valor) AS Informações_emprestimo
FROM TabelaEmprestimo

#Criando um identificador a partir do status e do ID do pagamento
SELECT id_pagamento, CONCAT(SUBSTR(status, 1, 3), id_pagamento) AS Código_Pagamento
FROM TabelaPagamentos

#Abreviando nomenclaturas de fontes de score de crédito
SELECT id_score, fonte, UPPER(Substr(fonte, 1, 3)) AS FonteAbreviado
FROM TabelaScoreCredito

#Alternativa do código anterior
SELECT 
    id_score, fonte, UPPER(REPLACE(REPLACE(Fonte, 'Boa Vista', 'BOA'), 'Serasa', 'SER')) AS FonteAbreviado
FROM TabelaScoreCredito;

#Corrigindo inconsistências - espaços
SELECT id_emprestimo, TRIM(tipo) AS Tipo
FROM TabelaEmprestimo
