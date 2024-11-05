

# R como calculadora ------------------------------------------------------

# ATALHO para rodar o código: CTRL + ENTER

# adição
2 + 5

# subtração
9 - 4

# multiplicação
5 * 2

# divisão
7/5

# potência
8 ^ 2

# raiz quadrada
sqrt(1024)

# raiz cúbica
27^(1/3)

# resto da divisão
9 %% 4

# parte inteira da divisão
7 %/% 4


# Funções Matemáticas -----------------------------------------------------

# funções trigonométricas
sin(1)
cos(1)
tan(1)

# logaritmo na base 10
log10(10)

# logaritmo natural (base e)
log(10)

# exponencial
exp(0.5)


# Objetos -----------------------------------------------------------------

# As bases de dados serão o nosso objeto de trabalho
mtcars

# O objeto mtcars já vem com a instalação do R
# Ele está sempre disponível

# Outros exemplos
pi
letters
LETTERS





nome <- "Fernanda Oliveira Costa"
nome

idade <- 40
idade

cargo_ou_funcao <- "Gerente de Projetos"
cargo_ou_funcao

salario <- 12000.00
salario


# Criando objetos ---------------------------------------------------------

# No dia-a-dia, a gente vai precisar criar os
# nossos próprios objetos

# chamamos de atribuição: <-

# Salvando o valor 1 no objeto "obj"
obj <- 1
obj

# Também dizemos 'guardando as saídas'
soma <- 2 + 2
soma

# ATALHO para a <- : ALT - (alt menos)

# Os nomes devem começar com uma letra.
# Podem conter letras, números, _ ou .
# Não se deve usar acentuações e/ou espaços.
# RECOMENDA-SE usar snake_case, isto é,
# palavras escritas em minúsculo separadas pelo underscore (_).

# Estilo de nomes

eu_uso_snake_case
outrasPessoasUsamCamelCase
algumas.pessoas.usam.pontos.mas.nao.deviam
E_algumasPoucas.Pessoas_RENUNCIAMconvenções

# Permitido

x <- 1
x1 <- 2
objeto <- 3
meu_objeto <- 4
meu.objeto <- 5

# Não permitido

1x <- 1
_objeto <- 2
meu-objeto <- 3


# O R é Case Sensitive, ou seja, faz diferenciação entre letras minúsculas e maiúsculas.
# Portanto, o objeto chamado de a é diferente do objeto chamado A.

a <- 2
A <- 4

# Salvar saída versus apenas executar
33 / 11
resultado <- 33 / 11

# Atualizar um objeto
resultado <- resultado * 5

# Salvar uma base de dados em um objeto
mtcars <- mtcars

# Para ver a base mtcars
View(mtcars)


# Operadores Relacionais --------------------------------------------------

# Igual a: ==
TRUE == TRUE
TRUE == FALSE

# Diferente de: !=

TRUE != TRUE
TRUE != FALSE

# Maior que: >
15 > 10
10 > 10
8 > 10

# Menor que: <
3 < 5
10 < 5
5 < 5

# Maior ou igual a: >=
15 >= 10
15 >= 15
15 >= 20

# Menor ou igual a: <=
10 <= 10
10 <= 8
8 <= 10


# Operadores Lógicos ------------------------------------------------------

# AND - E: &

# Será veradeiro (TRUE) se as duas condições forem verdadeiras

x <- 15
x>= 10 & x <= 20

y <- 7
y>= 10 & y <= 15


# OR - OU: |

# Será verdadeiro (TRUE) se uma das duas condições for verdadeira

x <- 5
x >= 10 | x <= 15

y <- 2
y >= 5 | y == 0

z <- 4
z > 2 | z == 2


# NOT - NEGAÇÃO: !
!TRUE
!FALSE

x <- 8
(!x < 5)


# Pertence ----------------------------------------------------------------

# Verificar se um valor está inserido dentro de um conjunto de valores (vetor)
# É representado pelo símbolo %in%

3 %in% c(1, 2, 3)

"a" %in% c("b", "c")


# Classes -----------------------------------------------------------------

mtcars

# Cada coluna da base representa uma variável
# Cada variável pode ser de um tipo (classe) diferente

# Podemos somar dois números
1 + 2

# Não podemos somar duas letras (texto)
"a" + "b"

##############################
# Use aspas para criar texto #
##############################

a <- 10

# O objeto a, sem aspas
a

# A letra (texto) a, com aspas
"a"

# Numéricos (numeric)
a <- 10
class(a)

# Caracteres (character, strings)
obj <- "a"
obj2 <- "masculino"

class(obj)
class(obj2)



# Data frames - TABELAS!
# tem linhas e colunas
# tibble, base de dados, dados tabulares

class(mtcars)


class(as.Date("2001-01-01"))

# Como acessar as colunas de uma base?
mtcars$mpg

# Como vemos a classe de uma coluna?
class(mtcars$mpg)

mtcars$mpg # chamei de conjunto mas o termo é VETOR

# remover objetos do environment
rm(a)
rm(falso)
rm(obj)




# Números -----------------------------------------------------------------


# Integer -----------------------------------------------------------------

# São os números inteiros
# São considerados números inteiros os números inteiros seguidos de L

class(5L)
class(20L)


# Double/Numeric ----------------------------------------------------------

# São os números racionais

class(5)
class(5.1) # double e numeric - aceita casas demais


# Lógicos ou Booleanos ----------------------------------------------------

# São representados por Verdadeiro (TRUE) ou Falso (FALSE)

class(TRUE)
class(FALSE)

# O R entende o TRUE = 1 e o FALSE = 0
# É possível realizar operações matemáticas

FALSE + FALSE
TRUE + TRUE
TRUE + FALSE


# Textos ------------------------------------------------------------------

# Qualquer código entre aspas será interpretado como texto (character)

class("TEXTO")
class("3")

escola <- c("Médio", "Superior", "Fundamental", "Fundamental", "Médio")
class(escola)


# Fatores -----------------------------------------------------------------

# São usados para representar categorias (ou factors)

# criando um fator
escola_categorias <- factor(c("Médio", "Superior", "Fundamental", "Fundamental", "Médio"))
escola_categorias
class(escola_categorias)

# A função as.factor() cria um objeto do tipo factor
# ou converte um objeto já existente.
# Na linha levels aparecem os rótulos do fator.


# NA ----------------------------------------------------------------------

# Representa um valor desconhecido ou ausente.
# As operações envolvendo NA também resultarão em valores desconhecidos.

NA > 10
NA + 10
NA / 5
10 == NA
NA == NA

# is.na() é a função que testa se um objeto é NA.

vetor_numerico <- c(NA, 1, 2, 3, 4, 5, NA)
is.na(vetor_numerico)

# na.rm = TRUE

sum(vetor_numerico)
sum(vetor_numerico, na.rm = TRUE)

mean(vetor_numerico)
mean(vetor_numerico, na.rm = TRUE)


# Conversão de Classes ----------------------------------------------------

vetor_logical <- c(TRUE, TRUE, FALSE, TRUE, FALSE)

# converte para número inteiro
as.integer(vetor_logical)

# converte para número
as.numeric(vetor_logical)

# converte pra texto
as.character(vetor_logical)

# converte pra fator
as.factor(vetor_logical)


frutas <- c("amora", "banana", "melancia")

# converte para número inteiro
as.integer(frutas)

# converte para número
as.numeric(frutas)

# converte para texto
as.character(frutas)

# converte pra fator
as.factor(frutas)


# Tipos de Objetos --------------------------------------------------------


# Vetores -----------------------------------------------------------------

# São conjuntos de valores.
# Armazenam elementos de uma mesma classe, em apenas uma dimensão.
# Para criá-los, use a função c().

primeiro_semestre <- c("Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho")
primeiro_semestre

# retorna o comprimento do vetor - quantos elementos ele tem?
length(primeiro_semestre)

# Uma maneira fácil de criar um vetor com uma sequência de números
# é utilizar o operador `:`

1:10 # vetor de 1 a 10
10:1 # vetor de 10 a 1
-5:5 # vetor de -5 a 5

# São conjuntos indexados: cada valor dentro do vetor tem uma posição.
# Essa posição é dada pela ordem em que os elementos foram dispostos
# no momento em que o vetor foi criado.
# É possível acessar individualmente cada valor de um vetor.
# Para acessar, basta colocar o índice do valor que deseja acessar dentro de conchetes [].

primeiro_semestre[1]
primeiro_semestre[1:2]

# remove o primeiro elemento do vetor
primeiro_semestre[-1]

# seleciona o elemento seis até o quarto (e muda a ordem dos elementos)
primeiro_semestre[6:4]

# É possível colocar um conjunto de índices dentro dos colchetes
# para pegar os valores contidos nessas posições.

# seleciona o primeiro, o terceiro e o quinto elemento do vetor
primeiro_semestre[c(1, 3, 5)]

# Essas operações são chamadas de subsetting:
# são acessados os subconjuntos de valores de um vetor.


# Um vetor só pode guardar um tipo de objeto
# e ele sempre terá a mesma classe dos objetos que guarda.
# Para saber a classe de um vetor, rode class().

class(primeiro_semestre)

anos_bissextos <- c(2000, 2004, 2008, 2012, 2016, 2020, 2024)

class(anos_bissextos)


# Coerção:
# Ao tentar misturar duas classes de elementos dentro de um vetor,
# o R vai apresentar o comportamento conhecido como coerção.

segundo_semestre <- c(7, 8, 9, 10, 11, "Dezembro")

segundo_semestre

class(segundo_semestre)

# Todos os elementos do vetor se transformaram texto.
# Classes mais fracas sempre serão reprimidas pelas classes mais fortes.

# character > numeric > integer > logical


# Operações com vetores:

vetor_numerico <- c(0, 5, 10, 15, 20)
vetor_numerico + 1

# Vetorização

# Operações que envolvem mais de um vetor:

vetor1 <- c(1, 2, 3)
vetor2 <- c(10, 20, 30)

vetor1 + vetor2

# O R alinha os dois vetores e soma elemento a elemento.


# Reciclagem:

# Ocorre quando os dois vetores não possuem o mesmo tamanho

vetor1 <- c(1, 2)
vetor2 <- c(10, 20, 30, 40)

vetor1 + vetor2

# O R alinha os dois vetores e, como eles não possuem o mesmo tamanho,
# o primeiro foi repetido para ficar do mesmo tamanho do segundo.
# É como se o primeiro vetore fosse c(1, 2, 1, 2).


# Caso interessante ocorre quando o comprimento dos vetores não são múltiplos:

vetor1 <- c(1, 2, 3)
vetor2 <- c(10, 20, 30, 40, 50)

vetor1 + vetor2

# A operação foi realizada, repetindo cada valor do primeiro vetor
# até que os dois tivessem o mesmo tamanho.
# A operação realizada foi c(1, 2, 3, 1, 2) + c(10, 20, 30, 40, 50).

# Como essa operação não é intuitiva, o R devolveu um aviso
# dizendo que o comprimento do primeiro vetor não é múltiplo
# do comprimento do segundo vetor.


# Filtro:

numeros <- c(-3, -1, 3, 5, 7, 10, 15)

# Aqui, o R fez uso da 'Reciclagem'.
# Ele transformou o valor 3 no vetor  c(3, 3, 3, 3, 3, 3, 3)
# e testou se c(-3, -1, 3, 5, 7, 10, 15) > c(3, 3, 3, 3, 3, 3, 3).
numeros > 3

# O R retornou as posições que receberam TRUE
# e não retornou as posições que receberam FALSE.
# A segunda operações é equivalente a:
# numeros[c(FALSE, FALSE, FALSE,  TRUE,  TRUE,  TRUE,  TRUE)]
numeros[numeros > 3]


# Matrizes ----------------------------------------------------------------

# São estruturas que correspondem às matrizes matemáticas.
# São conjuntos bidimensionais, contendo elementos dispostos em linhas e colunas.
# Todos os seus elementos são do mesmo tipo.
# São criados utilizando matrix().

matriz1 <- matrix(c(1:12), nrow = 3, ncol = 4)
matriz1

class(matriz1)
dim(matriz1) # dimensão da matriz - 3 linhas e 4 colunas

# É possível alterar a ordem de preenchimento da matriz
# (por linha ao invés de colunas)

matriz2 <- matrix(c(1:12), nrow = 3, ncol = 4, byrow = TRUE)
matriz2

class(matriz2)
dim(matriz2)  # dimensão da matriz - 3 linhas e 4 colunas


# Operações com Matrizes:

# multiplica por 2 cada elemento da matriz
matriz1 * 2

# obtém o resto da divisão entre as matrizes
matriz1 %% matriz2


# Listas ------------------------------------------------------------------

# São um tipo especial de vetor que
# podem conter uma coleção de diferentes classes.
# Possuem estrutura 'unidimensional',
# contando apenas o número de elementos integrantes.
# São criados usando a função list()

lista <- list(a = 1:10, b = c("T1", "T2", "T3", "T4"), TRUE, 2 + 2)
lista

class(lista)
dim(lista)
length(lista)


# Data Frame --------------------------------------------------------------

# São tabelas que possuem duas dimensões: linhas e colunas.
# Cada coluna pode ser de uma classe diferente.

mtcars

class(mtcars)
ncol(mtcars) # número de colunas
nrow(mtcars) # número de linhas
dim(mtcars) # dimensão - número de linhas e de colunas
str(mtcars) # algumas informações sobre a base
head(mtcars) # 6 primeiras linhas da tabela
tail(mtcars) # 6 últimas linhas da tabela


# Selecionando as colunas:

# Utilize o símbolo $.
# Dica: após escrever o nome_do_dataframe$,
# aperte Tab para receber as sugestões de colunas da base.

mtcars$cyl
mtcars$gear

# Subsetting:

# Seleciona elementos utilizando colchetes
# data_frame[linha, coluna]

mtcars[2, 3] # elemento presente na segunda linha da terceira coluna
mtcars[ , 1] # todas as linhas da coluna 1
mtcars[1, ] # todas as colunas da linha 1

# Para selecionar mais de uma coluna:
mtcars[, c(1, 2, 4)]
mtcars[, c("mpg", "cyl", "hp")]

# O mais recomendado é que se utilize o nome da coluna,
# uma vez que a posição das colunas pode mudar dentro do Data Frame.


# Filtrando colunas:

mtcars[mtcars$cyl == 4, ]


# É possível utilizar funções nas colunas do Data Frame

min(mtcars$mpg) # valor mínimo
max(mtcars$mpg) # valor máximo
mean(mtcars$mpg) # valor médio
median(mtcars$mpg) # valor da mediana


# Funções -----------------------------------------------------------------

# Responsáveis por guardar códigos de R.
# Sempre que uma função for rodada,
# o código que ela guarda será executado e um resultado será devolvido.

# As funções são tão comuns e intuitivas que,
# mesmo sem definir o que elas são,
# já utilizamos várias em seções anteriores:

c() # para criar vetores
class() # para descobrir a classe de um objeto
dim() # para verificar a dimensão de matriz/Data Frame
mean() # para encontrar a média de um vetor
max() # para encontrar o valor máximo de um vetor


# Estrutura de uma Função:

# - Nome: como ela fica salva no ambiente, é importante para 'chamar' a função
# - Argumentos: são os parâmetros usados internamente pela função
# - Corpo: o código que será utilizado

# estrutura para criar uma função
nome_da_funcao <- function(argumentos) {
  corpo da função
}
# para usar a função
nome_da_funcao(argumentos = ...)


# Argumentos:

# São os valores que colocamos dentro dos parênteses
# e que as funções precisam para funcionar.
# São sempre separados por vírgula.

# A função c() precisa saber quais são os valores
# que formarão o vetor que ela irá criar

c(1, 5, 10) # os valores 1, 5 e 10 são os argumentos da função c().


# Cada função pode funcionar de um jeito diferente das demais:

sum(1, 3) # retorna a soma dos argumentos
sum(c(1, 3)) # também é possível passar um vetor como argumento

# A função mean() exige que se passe os valores na forma de vetor:

mean(1, 3) # considera apenas o primeiro elemento
mean(c(1, 3)) # considera todos os valores dentro do vetor


# Os argumentos também têm nomes que podem (ou não) ser usados
# na hora de usar uma função.

seq(from = 4, to = 10, by = 2)

# Essa função possui os argumentos 'from=', 'to=' e 'by='.
# Ela cria uma sequência de 'by' em 'by' que começa em 'from' e termina em 'to'.

# Nesse caso, é preciso colocar os valores na ordem em que os argumentos aparecem.

seq(4, 10, 2)

# Escrevendo o nome dos argumentos,
# não há problema em alterar a ordem dos argumentos.

seq(by = 2, to = 10, from = 4)

# Mas se não especificar o nome dos argumentos,
# a ordem importa e o resultado será diferente.

seq(2, 10, 4)


# Funções importantes do R base:

head() # retorna as 6 primeiras linhas
tail() # retorna as 6 últimas linhas
dim() # retorna o número de linhas e colunas
names() # retorna os nomes das colunas (variáveis)
str() # retorna a estrutura do data frame
cbind() # acopla duas tabelas (lado a lado)
rbind() # empinha duas tabelas (uma acima da outra)
class() # retorna a classe do objeto
sum() # retorna a soma
mean()  # retorna a média
median()  # retorna a mediana
var()  # retorna a variância
sd()  # retorna o desvio-padrão
max()  # retorna o valor máximo
min()  # retorna o valor mínimo
round()  # retorna um valor arredondado


# Pacotes -----------------------------------------------------------------

# São as coleções de funções, dados e documentação.
# Precisam ser instalados e carregados.

# Um dos principais pacotes do R é o 'tidyverse'.

# - Instalação dos Pacotes:

install.packages("tidyverse") # via CRAN
devtools::install_github("tidyverse/dplyr") # via GitHub

# - Carregar os Pacotes:

library(tidyverse) # carrega todas as funções do(s) pacote(s)
dplyr::glimpse() # chama uma função específica de um pacote específico

# Só é preciso instalar o pacote uma vez,
# mas é necessário carregá-lo sempre que iniciar uma nova sessão.

# Para instalar o pacote use as aspas.
# Para carregar o pacote, não é necessário utilizar as aspas.
