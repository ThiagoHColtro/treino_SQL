#Calculando receita e despesas mensais
SELECT Mes, 
       Ano,
       'R$ ' || printf('%.2f', Quantidade * PrecoUnitario) AS Receita,
       'R$ ' || printf('%.2f', Quantidade * CustoUnitario) AS Despesas
FROM TabelaVendasMensais;

#Calculando o lucro bruto mensal 
SELECT mes, 
	ano,
       'R$ ' || printf('%.2f', (quantidade * precounitario) - (quantidade * custounitario)) AS LucroBrutoMensal
FROM TabelaVendasMensais;

#Margem de lucro bruto por mês
SELECT Mes, 
       Ano,
       ROUND(100.0 * ((Quantidade * PrecoUnitario) - (Quantidade * CustoUnitario)) / 
             (Quantidade * PrecoUnitario), 1)  AS MargemLucroBruto
FROM TabelaVendasMensais;

#Cálculo de lucro líquido mensal descontados 30% de impostos
SELECT Mes, 
       Ano,
       'R$ ' || ROUND((Quantidade * PrecoUnitario) - (Quantidade * CustoUnitario) - (Quantidade * CustoUnitario) * 0.30, 2) AS LucroLiquido
FROM TabelaVendasMensais;

#Mostra a quantidade de caixas necessárias para cada entrega
SELECT id_pedido, 
quantidadevendida, 
CEIL(quantidadevendida / 8) AS quantidadecaixas 
FROM TabelaPedidos

#Alternativamente: no SQLite online não há função CEIL, para compensar optei por uma solução matemática simples
SELECT id_pedido, 
quantidadevendida, 
ROUND((quantidadevendida + 8) / 8) AS quantidadecaixas 
FROM TabelaPedidos

#Cálculo do valor total após a aplicação de desconto por venda
SELECT id_pedido,
QuantidadeVendida,
PrecoUnitario,
Desconto,
'R$ ' || FLOOR((PrecoUnitario * QuantidadeVendida) * (1 - Desconto)) as precototal
FROM TabelaPedidos;

#Alternativamente: no SQLite online também não há função FLOOR
SELECT id_pedido, 
quantidadevendida, 
precounitario, 
desconto, 
'R$ ' || ROUND((quantidadevendida * precounitario) * ((quantidadevendida * precounitario) * desconto)) AS precototal
FROM TabelaPedidos

#Diferença entre as vendas de 2024 e a média das vendas mensais dos 5 últimos anos
SELECT mes, ano, 
ABS(vendasmensais - mediavendas5anos) AS DiferencaAbsolutaVendas
FROM TabelaMetasVendasMensais

#Cálculo de vendas estimatadas para 5 anos com base na taxa de crescimento pré-definida
SELECT ano, vendasbase, ROUND(POWER(1 + taxacrescimento, 5) * vendasbase) AS Estimativa5Anos 
FROM TabelaEstimativaCrescimento

#Cálculo de distancia entre a empresa e o endereço do cliente e se há cobrança da entrega
SELECT id_pedido, 
cidadecliente, 
ROUND(SQRT(POWER(latitude - -23.588161, 2) + POWER(longitude - -46.632344, 2)) * 111.19, 1) AS Distancia,
CASE 
	WHEN ROUND(SQRT(POWER(latitude - -23.588161, 2) + POWER(longitude - -46.632344, 2)) * 111.19, 1) < 60 
       THEN 'Entrega gratuita'
	ELSE 'Entrega com frete' 
	END AS StatusEntrega
FROM TabelaPedidos

#Cálculo do valor de entrega aplicável
SELECT id_pedido, 
cidadecliente, 
ROUND(SQRT(POWER(latitude - -23.588161, 2) + POWER(longitude - -46.632344, 2)) * 111.19, 1) AS Distancia,
CASE 
	WHEN ROUND(SQRT(POWER(latitude - -23.588161, 2) + POWER(longitude - -46.632344, 2)) * 111.19, 1) < 60 
       THEN 'R$ ' || 0
	ELSE 'R$ ' || (ROUND((quantidadevendida + 8) / 8)  * 50)
	END AS ValorEntrega
FROM TabelaPedidos
