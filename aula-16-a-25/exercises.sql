/* A16 - ENTRANDO COM MAIS TELEFONES */

UPDATE CLIENTE 
SET TELEFONE = '97865434'
WHERE NOME = 'JOAO';

UPDATE CLIENTE 
SET TELEFONE = '22923110 - 97865434'
WHERE NOME = 'JOAO';

SELECT ENDERECO, COUNT(*) AS "QUANTIDADE"
FROM CLIENTE
GROUP BY ENDERECO;

/* A17 - HISTORIA DA MODELAGEM */

/* DECADA DE 70, EUA - CRISE DO SOFTWARE
FOI A CRISE QUE ATINGIU NAO SOMENTE A AREA DE TECNOLOGIA
MAS TAMBÉM TODAS AS EMPRESAS QUE UTILIZAVAM DE SISTEMAS
TECNOLOGICOS PARA CONTROLAR SEUS NEGOCIOS.

NAQUELA EPOCA, PROGRAMAR ERA UM PROCESSO ARTESANAL.
BASTAVA OLHAR O CODIGO QUE VOCE SABERIA QUEM O
ESCREVEU, TAO POUCOS ERAM OS PROGRAMADORES EACHTAO ARCAICO ERAM
OS METODOS DE PROGRAMACAO. EM UM PRIMEIRO MOMENTO,
OS PROFISSIONAIS DE TI VIRAM A NECESSIDADE DE SE PROGRAMAR
E INICIARAM SUA CAMINHADA, CONSTRUINDO SISTEMAS QUE ATENDIAM
NUM PRIMEIRO MOMENTO, MAS DEPOIS TRAZIAM INFORMACOES ERRADAS,
PROVOCANDO A FALENCIA DE DIVERSAS EMPRESAS. LEMBRE-SE: INFORMACOES
ERRADAS PODEM LEVAR A SUA EMPRESA A FALENCIA, E FOI ISSO QUE ACONTECEU.
ISSO OCORRIA POIS OS PROFISSIONAIS SABIAM PROGRAMAR MAS ENTENDIAM APENAS
DO NEGOCIO DAS EMPRESAS DAS QUAIS FAZIAM PARTE. SER TER O KNOW HOW
DOS DEMAIS NEGOCIOS, OS PROGRAMADORES PROGRAMAVAM VOLTADOS PARA OS
PROCEDIMENTOS, E ESSE FOI UM ERRO MORTAL.

PETER CHEN, VENDO TODO ESSE CENARIO AFIRMOU: NAO PODEMOS CRIAR BANCOS
DE DADOS VOLTADOS PARA PROCEDIMENTOS EMPRESARIAIS, POIS OS PROCEDIMENTOS
SOFREM INTERFERENCIAS EXTERNAS E PODEM SER ALTERADOS. A UNICA COISA
QUE NAO SOFRE ALTERACAO SAO OS DADOS.

POR EXEMPLO, ARMAZENAMOS NO BANCO A VENDA DE JANEIRO, FEVEREIRO E MARCO
O TOTAL DAS VENDAS E O IMPOSTO PAGO AO GOVERNO. 
FAZEMOS ISSO DURANTE MUITO TEMPO. DE UMA HORA PRA OUTRA O GOVERNO
MUDA A ALIQUOTA DO IMPOSTO. COMO FARÁ SENTIDO OS PAGAMENTOS ARMAZENADOS
ANTERIORMENTE? AQUI NOTA-SE QUE ARMAZENAMOS DADOS E ARMAZENAMOS
INFORMACOES CORRESPONDENTES AOS PROCEDIMENTOS EXTERNOS. DEVEMOS
APENAS ARMAZENAR OS DADOS, POIS ELES SAO SUFICIENTES PARA GERAR
A INFORMACAO.

MODELAR É UMA ARTE, ALGO QUE SE APRENDE COM A PRATICA. E VOCES PODEM
SE PERGUNTAR: MAS SE É ALGO QUE SE APRENDE COM A PRATICA, COMO QUEM
ESTA COMEÇANDO, APRENDE?

ASSIM COMO PETER CHEN CRIOU O MODELO DE ENTIDADE E RELACIONAMENTO, O MER,
FORAM CRIADAS FORMAS NORMAIS, QUE SAO DIRETRIZES PARA APLICAR EM
MODELAGEM DE AMBIENTES OLTP OU AMBIENTES TRANSACIONAIS DE BANCOS
DE DADOS.

HOJE TEMOS MAIS DO QUE 3 FORMAS NORMAIS, MAS AO NORMALIZARMOS UM
BANCO ATE A SUA TERCEIRA FORMA, É O SUFICIENTE PARA TER UM
TRABALHO LIMPO E LIVRE DE ERROS. VEREMOS AS TRES FORMAS NORMAIS,
UMA A UMA, DETALHADAMENTE NAS PROXIMAS AULAS. */

/*  A18 */

INSERT INTO CLIENTE VALUES('CELIA','F','CELIA@GMAIL.COM',541521456,'58749965','RIACHUELO - CENTRO - RIO DE JANEIRO - RJ');

SELECT SEXO, COUNT(*) AS QUANTIDADE
FROM CLIENTE
GROUP BY SEXO;

/* 1a FORMA NORMAL */

/* 1 - TODO CAMPO VETORIZADO SE TORNARA
OUTRA TABELA

[AZUL,AMARELO,VERDE,LARANJA] - ELEMENTOS DE UM MESMO TIPO
[KA,FIT,FIESTA,CIVIC,UNO] - VETOR DE CARROS

2 - TODO CAMPO MULTIVALORADO SE TORNARÁ
OUTRA TABELA. UM CAMPO DIVISIVEL.

3 - TODA TABELA NECESSITA DE PELO MENOS
UM CAMPO QUE IDENTIFIQUE TODO O RESGISTRO
COMO SENDO ÚNICO - É O QUE CHAMAMOS DE CHAVE PRIMÁRIA
OU PRIMARY KEY*/

/* A19 - CADINALIDADE */

/* QUEM DEFINE A CARDINALIDADE É A REGRA DE NEGOCIOS */

/* PRIMEIRO ALGARISMO - OBRIGATORIEDADE 
0 - NAO OBRIGATORIO
1 - OBRIGATORIO

SEGUNDO ALGARISMO - CARDINALIDADE
1 - MAXIMO DE UM
N - MAIS DE UM
*/

/* MODELAGEM DE CLIENTE */

CREATE DATABASE COMERCIO;

USE COMERCIO;

CREATE TABLE CLIENTE(
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	SEXO ENUM('M','F') NOT NULL,
	EMAIL VARCHAR(50) UNIQUE,
	CPF VARCHAR(15) UNIQUE
);

CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
	TIPO ENUM('COM','RES','CEL'),
	NUMERO VARCHAR(10),
	ID_CLIENTE INT,
	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);

CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY AUTO_INCREMENT,
	RUA VARCHAR(30) NOT NULL,
	BAIRRO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	ESTADO CHAR(2) NOT NULL,
	ID_CLIENTE INT UNIQUE,
	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);

/* FOREIGN KEY - CHAVE ESTRANGEIRA - FK */

/* É A CHAVE PRIMARIA DE UMA TABELA, QUE VAI ATE
OUTRA TABELA FAZER REFERENCIA */

/* EM RELACIONAMENTOS 1 X 1 A CHAVE ESTRANGEIRA
FICA NA TABELA MAIS FRACA */

/* EM RELACIONAMENTOS 1 X N, A CHAVEE
ESTRANGEIRA FICARA SEMPRE NA TABELA N */

/* A20 */

INSERT INTO CLIENTE VALUES(NULL,'JOAO','M','JOAO@IG.COM','98547-6');
INSERT INTO CLIENTE VALUES(NULL,'CARLOS','M','CARLOS@TERA.COM','86664-7');
INSERT INTO CLIENTE VALUES(NULL,'ANA','F','ANA@GLOBO.COM','75658-5');
INSERT INTO CLIENTE VALUES(NULL,'JORGE','M','JORGE@IG.COM','88657-5');
INSERT INTO CLIENTE VALUES(NULL,'CLARA','M',NULL,'99754-7');
INSERT INTO CLIENTE VALUES(NULL,'CELIA','F','JOAO@TERRA.COM','77558-5');

SELECT * FROM CLIENTE;

/* INSERINDO UM REGISTRO ERRADO */

INSERT INTO CLIENTE VALUES(NULL,'ANTONIO','M','JOAO@IG.COM');

/*CORRIGINDO*/

INSERT INTO CLIENTE VALUES(NULL,'ANTONIO','M',NULL,'78558-6');
INSERT INTO CLIENTE VALUES(NULL,'JOAO','M',NULL,'86695-6');

/* ENDERECO */

INSERT INTO ENDERECO VALUES(NULL,'RUA A','CENTRO','B. HORIZONTE','MG',4);
INSERT INTO ENDERECO VALUES(NULL,'RUA B','CENTRO','RIO DE JANEIRO','RJ',1);
INSERT INTO ENDERECO VALUES(NULL,'RUA C','JARDINS','SAO PAULO','SP',3);
INSERT INTO ENDERECO VALUES(NULL,'RUA B','ESTACIO','RIO DE JANEIRO','RJ',8);
INSERT INTO ENDERECO VALUES(NULL,'RUA Z','CRUZEIRO','B. HORIZONTE','MG',2);
INSERT INTO ENDERECO VALUES(NULL,'RUA X','FLAMENGO','RIO DE JANEIRO','RJ',7);
INSERT INTO ENDERECO VALUES(NULL,'RUA Z','CRUZEIRO','B. HORIZONTE','MG',5);
INSERT INTO ENDERECO VALUES(NULL,'RUA X','CENTRO','NITERÓI','RJ',6);

INSERT INTO ENDERECO VALUES(NULL,'RUA U','CENTRO','NITERÓI','RJ',1000);

SELECT * FROM ENDERECO;

/* TELEFONE */

INSERT INTO TELEFONE VALUES(NULL,'CEL','9955331',1);
INSERT INTO TELEFONE VALUES(NULL,'COM','6574565',3);
INSERT INTO TELEFONE VALUES(NULL,'CEL','8864566',2);
INSERT INTO TELEFONE VALUES(NULL,'CEL','5557798',7);
INSERT INTO TELEFONE VALUES(NULL,'COM','6765768',1);
INSERT INTO TELEFONE VALUES(NULL,'RES','5676765',6);
INSERT INTO TELEFONE VALUES(NULL,'CEL','5765547',1);
INSERT INTO TELEFONE VALUES(NULL,'CEL','8865645',7);
INSERT INTO TELEFONE VALUES(NULL,'RES','7555446',7);
INSERT INTO TELEFONE VALUES(NULL,'CEL','5788654',3);
INSERT INTO TELEFONE VALUES(NULL,'CEL','7865644',6);
INSERT INTO TELEFONE VALUES(NULL,'RES','5754644',6);

SELECT * FROM CLIENTE;
SELECT * FROM ENDERECO;
SELECT * FROM TELEFONE;

/* A 21 */

/* SELECAO, PROJECAO E JUNCAO */

/* PROJECAO - TUDO QUE QUEREMOS PROJETAR NA TELA */

SELECT NOW() AS "DATA";

SELECT NOME, NOW() AS "DATA" /* PROJECAO */
FROM CLIENTE;

/* SELECAO - TEORIA DOS CONJUNTOS - WHERE É A CLAUSULA DE SELECAO */

SELECT NOME, SEXO 
FROM CLIENTE;

SELECT NOME, SEXO 
FROM CLIENTE
WHERE SEXO = 'M'; /* SELECAO */

UPDATE CLIENTE
SET SEXO = 'F'
WHERE IDCLIENTE = 5; /*SELECAO */

/* JUNCAO  */

/* NOME, SEXO, BAIRRO, CIDADE, DATA */

SELECT NOME, SEXO, BAIRRO, CIDADE, NOW() AS "DATA"
FROM CLIENTE, ENDERECO
WHERE IDCLIENTE = ID_CLIENTE; /* SELECAO - NAO FAÇAM ISSO */

SELECT NOME, SEXO, BAIRRO, CIDADE, NOW() AS "DATA"
FROM CLIENTE, ENDERECO
WHERE IDCLIENTE = ID_CLIENTE
AND BAIRRO = 'CENTRO';

/* JOIN - JUNCAO */

SELECT NOME, SEXO, BAIRRO, CIDADE /* PROJECAO */
FROM CLIENTE
INNER JOIN ENDERECO /*JUNCAO */
ON IDCLIENTE = ID_CLIENTE
WHERE BAIRRO = 'CENTRO'; /* SELECAO */

SELECT CLIENTE.NOME, CLIENTE.SEXO, 
ENDERECO.BAIRRO, ENDERECO.CIDADE, 
TELEFONE.TIPO, TELEFONE.NUMERO
FROM CLIENTE 
INNER JOIN ENDERECO
ON CLIENTE.IDCLIENTE = ENDERECO.ID_CLIENTE
INNER JOIN TELEFONE
ON CLIENTE.IDCLIENTE = TELEFONE.ID_CLIENTE;

SELECT C.NOME, C.SEXO, 
E.BAIRRO, E.CIDADE, 
T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;


SELECT C.NOME, C.SEXO, 
E.BAIRRO, E.CIDADE, 
T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'M';


/* A23 Queries - SELECAO - PROJECAO E JUNCAO */

/* PARA UMA CAMPANHA DE MARKETING, O SETOR SOLICITOU UM
RELATÓRIO COM O NOME, EMAIL E TELEFONE CELULAR 
DOS CLIENTES QUE MORAM NO ESTADO DO RIO DE JANEIRO 
VOCÊ TERÁ QUE PASSAR A QUERY PARA GERAR O RELATORIO PARA
O PROGRAMADOR */

SELECT C.NOME,C.EMAIL,T.NUMERO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
WHERE TIPO = 'CEL' AND ESTADO = 'RJ';

+---------+----------------+---------+
| NOME    | EMAIL          | NUMERO  |
+---------+----------------+---------+
| JOAO    | JOAO@IG.COM    | 9955331 |
| JOAO    | JOAO@IG.COM    | 5765547 |
| ANTONIO | NULL           | 5557798 |
| ANTONIO | NULL           | 8865645 |
| CELIA   | JOAO@TERRA.COM | 7865644 |
+---------+----------------+---------+

/* PARA UMA CAMPANHA DE PRODUTOS DE BELEZA, O COMERCIAL SOLICITOU UM
RELATÓRIO COM O NOME, EMAIL E TELEFONE CELULAR 
 DAS MULHERES QUE MORAM NO ESTADO DE SÃO PAULO 
VOCÊ TERÁ QUE PASSAR A QUERY PARA GERAR O RELATORIO PARA
O PROGRAMADOR */

SELECT NOME, EMAIL, NUMERO
FROM CLIENTE
INNER JOIN TELEFONE T
ON IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON IDCLIENTE = E.ID_CLIENTE
WHERE SEXO = 'F' AND TIPO = 'CEL' AND ESTADO = 'SP';

+------+---------------+---------+
| NOME | EMAIL         | NUMERO  |
+------+---------------+---------+
| ANA  | ANA@GLOBO.COM | 5788654 |
+------+---------------+---------+

/* IFNULL */

SELECT C.NOME AS "CLIENTE",
	   IFNULL(C.EMAIL,'SEM EMAIL') AS "EMAIL",
	   T.NUMERO AS "CELULAR"
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
WHERE TIPO = 'CEL' AND ESTADO = 'RJ';

+---------+----------------+---------+
| NOME    | EMAIL          | NUMERO  |
+---------+----------------+---------+
| JOAO    | JOAO@IG.COM    | 9955331 |
| JOAO    | JOAO@IG.COM    | 5765547 |
| ANTONIO | SEM EMAIL      | 5557798 |
| ANTONIO | SEM EMAIL      | 8865645 |
| CELIA   | JOAO@TERRA.COM | 7865644 |
+---------+----------------+---------+

/* A24 - VIEWS OU VISOES */

SELECT C.NOME,C.SEXO,
	   IFNULL(C.EMAIL,'SEM EMAIL') AS "E-MAIL",
	   T.TIPO,
	   T.NUMERO,
       E.BAIRRO,
	   E.CIDADE,
	   E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;

/* CRIANDO A VIEW */

CREATE VIEW RELATORIO AS
SELECT C.NOME,C.SEXO,
	   IFNULL(C.EMAIL,'SEM EMAIL') AS "E-MAIL",
	   T.TIPO,
	   T.NUMERO,
       E.BAIRRO,
	   E.CIDADE,
	   E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;

SELECT * FROM RELATORIO;

SELECT * FROM RELATORIO
WHERE SEXO = 'F';

SHOW TABLES;
+--------------------+
| Tables_in_comercio |
+--------------------+
| cliente            |
| endereco           |
| relatorio          |
| telefone           |
+--------------------+

/* APAGANDO UMA VIEW */

DROP VIEW RELATORIO;

CREATE VIEW V_RELATORIO AS
SELECT C.NOME,C.SEXO,
	   IFNULL(C.EMAIL,'SEM EMAIL') AS "E-MAIL",
	   T.TIPO,
	   T.NUMERO,
       E.BAIRRO,
	   E.CIDADE,
	   E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;

SELECT NOME, SEXO, CIDADE
FROM V_RELATORIO;

+---------+------+----------------+
| NOME    | SEXO | CIDADE         |
+---------+------+----------------+
| JOAO    | M    | RIO DE JANEIRO |
| JOAO    | M    | RIO DE JANEIRO |
| JOAO    | M    | RIO DE JANEIRO |
| CARLOS  | M    | B. HORIZONTE   |
| ANA     | F    | SAO PAULO      |
| ANA     | F    | SAO PAULO      |
| CELIA   | F    | NITERÓI        |
| CELIA   | F    | NITERÓI        |
| CELIA   | F    | NITERÓI        |
| ANTONIO | M    | RIO DE JANEIRO |
| ANTONIO | M    | RIO DE JANEIRO |
| ANTONIO | M    | RIO DE JANEIRO |
+---------+------+----------------+

DELETE FROM V_RELATORIO
WHERE NOME = 'JOAO';

Can not delete from join view 'comercio.v_relatorio'

INSERT INTO V_RELATORIO VALUES
('ROMARIO','M',NULL,'RES','99723882','BARRA','RIO DE JANEIRO','RJ');

Can not insert into join view 'comercio.v_relatorio' without fields list

/* A 25 - ORDER BY */

SELECT NOME, SEXO, CPF, CIDADE
FROM CLIENTE
INNER JOIN ENDERECO
ON IDCLIENTE = ID_CLIENTE;

SELECT NOME, SEXO, CPF, CIDADE
FROM CLIENTE
INNER JOIN ENDERECO
ON IDCLIENTE = ID_CLIENTE
ORDER BY NOME;

SELECT NOME, SEXO, CPF, CIDADE
FROM CLIENTE
INNER JOIN ENDERECO
ON IDCLIENTE = ID_CLIENTE
ORDER BY NOME, CPF ASC;

SELECT NOME, SEXO, CPF, CIDADE
FROM CLIENTE
INNER JOIN ENDERECO
ON IDCLIENTE = ID_CLIENTE
ORDER BY 4;
