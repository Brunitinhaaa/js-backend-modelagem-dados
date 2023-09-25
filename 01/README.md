# Exercício 01

## Modelando e criando Banco de dados

# Sistema de Vendas Online para Supermercado

Este repositório contém a documentação para o sistema de vendas online desenvolvido para um supermercado. O projeto inclui a criação do banco de dados, a inserção de dados e a realização de vendas.

## Descrição

O projeto se refere a um sistema de vendas online desenvolvido para um supermercado. O objetivo principal é permitir que os clientes façam compras pela internet, escolhendo produtos a partir de uma variedade de categorias. O sistema também gerencia as vendas realizadas por vendedores.

### Funcionalidades Principais

1. **Banco de Dados**: O projeto começa com a criação de um banco de dados chamado `ecommerce`, que é responsável por armazenar todas as informações necessárias para o funcionamento do sistema.

2. **Modelagem de Dados**: O banco de dados foi modelado de acordo com as necessidades do supermercado. As principais tabelas incluem:
   - `categorias`: Para armazenar categorias de produtos.
   - `produtos`: Para armazenar informações detalhadas sobre os produtos, incluindo nome, descrição, preço e quantidade em estoque.
   - `clientes`: Para registrar informações sobre os clientes, como CPF e nome.
   - `vendedores`: Para registrar informações sobre os vendedores, também com CPF e nome.

3. **Inserção de Dados**: Foram inseridos dados nas tabelas do banco de dados para simular um ambiente real. Isso incluiu adicionar categorias de produtos, informações sobre produtos específicos, dados de clientes e vendedores.

4. **Vendas**: O sistema permite a realização de vendas. As vendas incluem informações sobre os produtos vendidos, os clientes que fizeram as compras e os vendedores responsáveis pelas vendas.

5. **Atualização de Estoque**: Após cada venda, o sistema faz uma atualização automática do estoque de produtos, garantindo que a quantidade em estoque seja atualizada corretamente.

6. **Relatórios**: Embora não mencionado diretamente nas instruções, é possível que o sistema gere relatórios de vendas, lucros, estoque, entre outros, para ajudar na gestão do supermercado.

7. **Script SQL**: Todos os comandos SQL utilizados para criar o banco de dados, inserir dados e realizar vendas estão disponíveis no arquivo `query.sql`. Esse arquivo é uma representação do script SQL usado para configurar o banco de dados e realizar as operações necessárias.

tabela `categorias` 

| nome       |
| ---------- |
| frutas     |
| verduras   |
| massas     |
| bebidas    |
| utilidades |

tabela `produtos`

| nome                        | descricao                                                                                                    | preco | quantidade_em_estoque | categoria_id              |
| --------------------------- | ------------------------------------------------------------------------------------------------------------ | ----- | --------------------- | ------------------------- |
| Mamão                       | Rico em vitamina A, potássio e vitamina C                                                                    | 300   | 123                   | `id_categoria_frutas`     |
| Maça                        | Fonte de potássio e fibras.                                                                                  | 90    | 34                    | `id_categoria_frutas`     |
| Cebola                      | Rico em quercetina, antocianinas, vitaminas do complexo B, C.                                                | 50    | 76                    | `id_categoria_verduras`   |
| Abacate                     | NÃO CONTÉM GLÚTEN.                                                                                           | 150   | 64                    | `id_categoria_frutas`     |
| Tomate                      | Rico em vitaminas A, B e C.                                                                                  | 125   | 88                    | `id_categoria_verduras`   |
| Acelga                      | NÃO CONTÉM GLÚTEN.                                                                                           | 235   | 13                    | `id_categoria_verduras`   |
| Macarrão parafuso           | Sêmola de trigo enriquecida com ferro e ácido fólico, ovos e corantes naturais                               | 690   | 5                     | `id_categoria_massas`     |
| Massa para lasanha          | Uma reunião de família precisa ter comida boa e muita alegria.                                               | 875   | 19                    | `id_categoria_massas`     |
| Refrigerante coca cola lata | Sabor original                                                                                               | 350   | 189                   | `id_categoria_bebidas`    |
| Refrigerante Pepsi 2l       | NÃO CONTÉM GLÚTEN. NÃO ALCOÓLICO.                                                                            | 700   | 12                    | `id_categoria_bebidas`    |
| Cerveja Heineken 600ml      | Heineken é uma cerveja lager Puro Malte, refrescante e de cor amarelo-dourado                                | 1200  | 500                   | `id_categoria_bebidas`    |
| Agua mineral sem gás        | Smartwater é água adicionado de sais mineirais (cálcio, potássio e magnésio) livre de sódio e com pH neutro. | 130   | 478                   | `id_categoria_bebidas`    |
| Vassoura                    | Pigmento, matéria sintética e metal.                                                                         | 2350  | 30                    | `id_categoria_utilidades` |
| Saco para lixo              | Reforçado para garantir mais segurança                                                                       | 1340  | 90                    | `id_categoria_utilidades` |
| Escova dental               | Faça uma limpeza profunda com a tecnologia inovadora                                                         | 1000  | 44                    | `id_categoria_utilidades` |
| Balde para lixo 50l         | Possui tampa e fabricado com material reciclado                                                              | 2290  | 55                    | `id_categoria_utilidades` |
| Manga                       | Rico em Vitamina A, potássio e vitamina C                                                                    | 198   | 176                   | `id_categoria_frutas`     |
| Uva                         | NÃO CONTÉM GLÚTEN.                                                                                           | 420   | 90                    | `id_categoria_frutas`     |

Obs.: informe o `id` da `categoria_id` referente a cada produto. Ex.: frutas `categoria_id = 1`.

tabela `clientes`

| cpf            | nome               |
| -------------- | ------------------ |
| 803.713.500-42 | José Augusto Silva |
| 676.428.690-61 | Antonio Oliveira   |
| 631.933.100-34 | Ana Rodrigues      |
| 756.705.050-18 | Maria da Conceição |

tabela `vendedores`

| cpf            | nome                 |
| -------------- | -------------------- |
| 825.398.410-31 | Rodrigo Sampaio      |
| 232.625.460-03 | Beatriz Souza Santos |
| 280.071.550-23 | Carlos Eduardo       |

###### tags: `exercícios` `banco de dados` `sql` `postgres`
