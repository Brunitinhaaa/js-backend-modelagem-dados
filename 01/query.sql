CREATE DATABASE ecommerce;

CREATE TABLE categorias (
    ID SERIAL PRIMARY KEY,
    NOME VARCHAR(50)
);

CREATE TABLE produtos (
    ID SERIAL PRIMARY KEY,
    NOME VARCHAR(100),
    DESCRICAO TEXT,
    PRECO INTEGER,
    QUANTIDADE_EM_ESTOQUE INTEGER,
    CATEGORIA_ID INTEGER REFERENCES CATEGORIAS(ID)
);

CREATE TABLE clientes (
    CPF CHAR(11) UNIQUE,
    NOME VARCHAR(150)
);

CREATE TABLE vendedores (
    CPF CHAR(11) UNIQUE,
    NOME VARCHAR(150)
);

CREATE TABLE pedidos (
    ID SERIAL PRIMARY KEY,
    VALOR INTEGER,
    CLIENTE_CPF CHAR(11) REFERENCES CLIENTES(CPF),
    VENDEDOR_CPF CHAR(11) REFERENCES VENDEDORES(CPF)
);

CREATE TABLE itens_do_pedido (
    ID SERIAL PRIMARY KEY,
    PEDIDO_ID INTEGER REFERENCES PEDIDOS(ID),
    QUNATIDADE INTEGER,
    PRODUTO_ID INTEGER REFERENCES PRODUTOS(ID)
);

INSERT INTO categorias
(nome)
VALUES
('frutas'),
('verduras'),
('massas'),
('bebidas'),
('utilidades');

INSERT INTO produtos
(nome, descricao, preco, quantidade_em_estoque, categoria_id)
VALUES
('Mamão', 'Rico em vitamina A, potássio e vitamina C', 300, 123, 1),
('Maça', 'Fonte de potássio e fibras.', 90, 34, 1),
('Cebola', 'Rico em quercetina, antocianinas, vitaminas do complexo B, C.', 50, 76, 2),
('Abacate', 'NÃO CONTÉM GLÚTEN.', 150, 64, 1),
('Tomate', 'Rico em vitaminas A, B e C.', 125, 88, 2),
('Acelga', 'NÃO CONTÉM GLÚTEN.', 235, 13, 2),
('Macarrão parafuso', 'Sêmola de trigo enriquecida com ferro e ácido fólico, ovos e corantes naturais', 690, 5, 3),
('Massa para lasanha', 'Uma reunião de família precisa ter comida boa e muita alegria.', 875, 19, 3),
('Refrigerante coca cola lata', 'Sabor original', 350, 189, 4),
('Refrigerante Pepsi 2l', 'NÃO CONTÉM GLÚTEN. NÃO ALCOÓLICO.', 700, 12, 4),
('Cerveja Heineken 600ml', 'Heineken é uma cerveja lager Puro Malte, refrescante e de cor amarelo-dourado', 1200, 500, 4),
('Agua mineral sem gás', 'Smartwater é água adicionado de sais mineirais (cálcio, potássio e magnésio) livre de sódio e com pH neutro.', 130, 478, 4),
('Vassoura', 'Pigmento, matéria sintética e metal.', 2350, 30, 5),
('Saco para lixo', 'Reforçado para garantir mais segurança', 1340, 90, 5),
('Escova dental', 'Faça uma limpeza profunda com a tecnologia inovadora', 1000, 44, 5),
('Balde para lixo 50l', 'Possui tampa e fabricado com material reciclado', 2290, 55, 5),
('Manga', 'Rico em Vitamina A, potássio e vitamina C', 198, 176, 1),
('Uva', 'NÃO CONTÉM GLÚTEN.', 420, 90, 1);

ALTER TABLE clientes
ALTER COLUMN cpf
TYPE CHAR(11);

ALTER TABLE vendedores
ALTER COLUMN cpf
TYPE CHAR(11);

INSERT INTO clientes
(cpf, nome)
VALUES
('80371350042', 'José Augusto Silva'),
('67642869061', 'Antonio Oliveira'),
('63193310034', 'Ana Rodrigues'),
('75670505018', 'Maria da Conceição');

INSERT INTO vendedores
(cpf, nome)
VALUES
('82539841031', 'Rodrigo Sampaio'),
('23262546003', 'Beatriz Souza Santos'),
('28007155023', 'ACarlos Eduardo');

-- Venda de José Augusto com o vendedor Carlos Eduardo
-- 1 Mamão, 1 Pepsi de 2l, 6 Heinekens de 600ml, 1 Escova dental e 5 Maçãs.
INSERT INTO pedidos (valor, cliente_cpf, vendedor_cpf)
VALUES (
    (SELECT 
        (SELECT preco FROM produtos WHERE nome = 'Mamão') + 
        (SELECT preco FROM produtos WHERE nome = 'Pepsi 2l') + 
        (SELECT 6 * preco FROM produtos WHERE nome = 'Cerveja Heineken 600ml') + 
        (SELECT preco FROM produtos WHERE nome = 'Escova dental') + 
        (SELECT 5 * preco FROM produtos WHERE nome = 'Maça')
    ),
    '803.713.500-42',
    '280.071.550-23'
);

-- Inserir os itens do pedido para José Augusto
INSERT INTO itens_do_pedido (pedido_id, quantidade, produto_id)
VALUES
((SELECT currval('pedidos_id_seq')),
 1, (SELECT id FROM produtos WHERE nome = 'Mamão')),
((SELECT currval('pedidos_id_seq')),
 1, (SELECT id FROM produtos WHERE nome = 'Pepsi 2l')),
((SELECT currval('pedidos_id_seq')),
 6, (SELECT id FROM produtos WHERE nome = 'Cerveja Heineken 600ml')),
((SELECT currval('pedidos_id_seq')),
 1, (SELECT id FROM produtos WHERE nome = 'Escova dental')),
((SELECT currval('pedidos_id_seq')),
 5, (SELECT id FROM produtos WHERE nome = 'Maça'));

-- Atualizar o estoque dos produtos vendidos
UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 1
WHERE nome = 'Mamão';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 1
WHERE nome = 'Pepsi 2l';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 6
WHERE nome = 'Cerveja Heineken 600ml';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 1
WHERE nome = 'Escova dental';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 5
WHERE nome = 'Maça';


-- Venda de Ana Rodrigues com a vendedora Beatriz Souza Santos
-- 10 Mangas, 3 Uvas, 5 Mamões, 10 tomates e 2 Acelgas.
INSERT INTO pedidos (valor, cliente_cpf, vendedor_cpf)
VALUES (
    (SELECT 
        (SELECT 10 * preco FROM produtos WHERE nome = 'Manga') + 
        (SELECT 3 * preco FROM produtos WHERE nome = 'Uva') + 
        (SELECT 5 * preco FROM produtos WHERE nome = 'Mamão') + 
        (SELECT 10 * preco FROM produtos WHERE nome = 'Tomate') + 
        (SELECT 2 * preco FROM produtos WHERE nome = 'Acelga')
    ),
    '631.933.100-34',
    '232.625.460-03'
);

-- Inserir os itens do pedido para Ana Rodrigues
INSERT INTO itens_do_pedido (pedido_id, quantidade, produto_id)
VALUES
((SELECT currval('pedidos_id_seq')),
 10, (SELECT id FROM produtos WHERE nome = 'Manga')),
((SELECT currval('pedidos_id_seq')),
 3, (SELECT id FROM produtos WHERE nome = 'Uva')),
((SELECT currval('pedidos_id_seq')),
 5, (SELECT id FROM produtos WHERE nome = 'Mamão')),
((SELECT currval('pedidos_id_seq')),
 10, (SELECT id FROM produtos WHERE nome = 'Tomate')),
((SELECT currval('pedidos_id_seq')),
 2, (SELECT id FROM produtos WHERE nome = 'Acelga'));

-- Atualizar o estoque dos produtos vendidos
UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 10
WHERE nome = 'Manga';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 3
WHERE nome = 'Uva';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 5
WHERE nome = 'Mamão';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 10
WHERE nome = 'Tomate';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 2
WHERE nome = 'Acelga';

-- venda de Maria da Conceição com a vendedora Beatriz Souza Santos
-- 1 Vassoura, 6 Águas sem gás e 5 Mangas.

INSERT INTO pedidos (valor, cliente_cpf, vendedor_cpf)
VALUES (
    (SELECT 
        (SELECT preco FROM produtos WHERE nome = 'Vassoura') + 
        (SELECT 6 * preco FROM produtos WHERE nome = 'Agua mineral sem gás') + 
        (SELECT 5 * preco FROM produtos WHERE nome = 'Manga')
    ),
    '756.705.050-18',
    '232.625.460-03'
);

-- Inserir os itens do pedido para Maria da Conceição
INSERT INTO itens_do_pedido (pedido_id, quantidade, produto_id)
VALUES
((SELECT currval('pedidos_id_seq')),
 1, (SELECT id FROM produtos WHERE nome = 'Vassoura')),
((SELECT currval('pedidos_id_seq')),
 6, (SELECT id FROM produtos WHERE nome = 'Agua mineral sem gás')),
((SELECT currval('pedidos_id_seq')),
 5, (SELECT id FROM produtos WHERE nome = 'Manga'));

-- Atualizar o estoque dos produtos vendidos
UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 1
WHERE nome = 'Vassoura';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 6
WHERE nome = 'Agua mineral sem gás';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 5
WHERE nome = 'Manga';


-- venda de Maria da Conceição com o vendedor Rodrigo Sampaio
-- 1 Balde para lixo, 6 Uvas, 1 Macarrão parafuso, 3 Mamões, 20 tomates e 2 Acelgas.
INSERT INTO pedidos (valor, cliente_cpf, vendedor_cpf)
VALUES (
    (SELECT 
        (SELECT preco FROM produtos WHERE nome = 'Balde para lixo 50l') + 
        (SELECT 6 * preco FROM produtos WHERE nome = 'Uva') + 
        (SELECT preco FROM produtos WHERE nome = 'Macarrão parafuso') + 
        (SELECT 3 * preco FROM produtos WHERE nome = 'Mamão') + 
        (SELECT 20 * preco FROM produtos WHERE nome = 'Tomate') + 
        (SELECT 2 * preco FROM produtos WHERE nome = 'Acelga')
    ),
    '756.705.050-18',
    '825.398.410-31'
);

-- Inserir os itens do pedido para Maria da Conceição
INSERT INTO itens_do_pedido (pedido_id, quantidade, produto_id)
VALUES
((SELECT currval('pedidos_id_seq')),
 1, (SELECT id FROM produtos WHERE nome = 'Balde para lixo 50l')),
((SELECT currval('pedidos_id_seq')),
 6, (SELECT id FROM produtos WHERE nome = 'Uva')),
((SELECT currval('pedidos_id_seq')),
 1, (SELECT id FROM produtos WHERE nome = 'Macarrão parafuso')),
((SELECT currval('pedidos_id_seq')),
 3, (SELECT id FROM produtos WHERE nome = 'Mamão')),
((SELECT currval('pedidos_id_seq')),
 20, (SELECT id FROM produtos WHERE nome = 'Tomate')),
((SELECT currval('pedidos_id_seq')),
 2, (SELECT id FROM produtos WHERE nome = 'Acelga'));

-- Atualizar o estoque dos produtos vendidos
UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 1
WHERE nome = 'Balde para lixo 50l';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 6
WHERE nome = 'Uva';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 1
WHERE nome = 'Macarrão parafuso';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 3
WHERE nome = 'Mamão';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 20
WHERE nome = 'Tomate';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 2
WHERE nome = 'Acelga';


-- venda de Antonio Oliveira com o vendedor Rodrigo Sampaio
-- 8 Uvas, 1 Massa para lasanha, 3 Mangas, 8 tomates e 2 Heinekens 600ml
INSERT INTO pedidos (valor, cliente_cpf, vendedor_cpf)
VALUES (
    (SELECT 
        (SELECT 8 * preco FROM produtos WHERE nome = 'Uva') + 
        (SELECT preco FROM produtos WHERE nome = 'Massa para lasanha') + 
        (SELECT 3 * preco FROM produtos WHERE nome = 'Manga') + 
        (SELECT 8 * preco FROM produtos WHERE nome = 'Tomate') + 
        (SELECT 2 * preco FROM produtos WHERE nome = 'Cerveja Heineken 600ml')
    ),
    '676.428.690-61',
    '825.398.410-31'
);

-- Inserir os itens do pedido para Antonio Oliveira
INSERT INTO itens_do_pedido (pedido_id, quantidade, produto_id)
VALUES
((SELECT currval('pedidos_id_seq')),
 8, (SELECT id FROM produtos WHERE nome = 'Uva')),
((SELECT currval('pedidos_id_seq')),
 1, (SELECT id FROM produtos WHERE nome = 'Massa para lasanha')),
((SELECT currval('pedidos_id_seq')),
 3, (SELECT id FROM produtos WHERE nome = 'Manga')),
((SELECT currval('pedidos_id_seq')),
 8, (SELECT id FROM produtos WHERE nome = 'Tomate')),
((SELECT currval('pedidos_id_seq')),
 2, (SELECT id FROM produtos WHERE nome = 'Cerveja Heineken 600ml'));

-- Atualizar o estoque dos produtos vendidos
UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 8
WHERE nome = 'Uva';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 1
WHERE nome = 'Massa para lasanha';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 3
WHERE nome = 'Manga';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 8
WHERE nome = 'Tomate';

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 2
WHERE nome = 'Cerveja Heineken 600ml';

