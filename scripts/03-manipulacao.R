

# Pacotes necessários -----------------------------------------------------

library(tidyverse)


# Importando as bases -----------------------------------------------------

pinguins <- read_csv("dados/pinguins/pinguins.csv")


# Pacote dplyr ------------------------------------------------------------

# SELECT()
# seleciona colunas

# seleciona uma coluna
select(pinguins, especie)

# seleciona mais de uma coluna
select(pinguins, especie, sexo, massa_corporal)

# seleciona colunas consecutivas
select(pinguins, ilha:massa_corporal)


# Conjunto de funções auxiliares úteis para a seleção de colunas.

# starts_with(): para colunas que começam com um texto padrão
# ends_with(): para colunas que terminam com um texto padrão
# contains(): para colunas que contêm um texto padrão

# seleciona todas as colunas que terminam com "bico"
select(pinguins, ends_with("bico"))

# exclui as colunas ano e ensino
select(pinguins, -ano)
select(pinguins, -c(ano, sexo))


# ARRANGE()
# ordena as linhas

# ordena as linhas em ordem crescente
arrange(pinguins, massa_corporal)

# ordena as linhas em ordem decrescente
arrange(pinguins, desc(massa_corporal))

# ordena as linhas de mais de uma coluna
# neste caso, uma em ordem descrescente e outra em ordem crescente
arrange(pinguins, desc(comprimento_bico), profundidade_bico)



# sem pipe
arrange(select(pinguins, especie, massa_corporal), massa_corporal)

# com pipe - LEITURA MAIS INTUITIVA
pinguins %>%
  select(especie, massa_corporal) %>%
  arrange(massa_corporal)



# FILTER()
# filtra os valores (linhas) de uma coluna

# filtra as linhas da coluna comprimento_nadadeira acima de 140 mm
filter(pinguins, comprimento_nadadeira > 140)

# seleciona apenas as colunas da espécie e comprimento_nadadeira
# e filtra as nadadeiras com mais de 140 mm
pinguins %>%
  select(especie, comprimento_nadadeira) %>%
  filter(comprimento_nadadeira > 140)

# estende o filtro para mais de uma coluna
# cada operação é separada por uma vírgula
pinguins %>%
  filter(ilha == "Torgersen", profundidade_bico > 15)

# é possível realizar operações com as colunas dentro da função filter()
pinguins %>%
  filter(massa_corporal > mean(massa_corporal, na.rm = TRUE))



# MUTATE()
# cria novas colunas ou
# modifica colunas já existentes

# modifica uma coluna já existente
pinguins %>%
  mutate(comprimento_bico = comprimento_bico/10)

# cria uma coluna (variável) nova
pinguins %>%
  mutate(comprimento_bico_cm = comprimento_bico/10)

# é possível criar/modificar mais de uma coluna
#dentro de um mesmo mutate()
pinguins %>%
  mutate(
    media_comprimento_bico = mean(comprimento_bico, na.rm = TRUE),
    pais = "Antártida"
  ) %>%
  select(especie, media_comprimento_bico, pais)



# SUMMARISE() ou SUMMARIZE()
# resume um conjunto de dados

# resume a coluna ideb pela sua média
pinguins %>%
  summarise(media_massa_corporal = mean(massa_corporal, na.rm = TRUE))


# várias sumarizações podem ser realizadas na mesma função
# cada sumarização será uma coluna
pinguins %>%
  summarise(
    media_comprimento_nadadeira = mean(comprimento_nadadeira, na.rm = TRUE),
    mediana_comprimento_nadadeira = median(comprimento_nadadeira, na.rm = TRUE),
    variancia_comprimento_nadadeira = var(comprimento_nadadeira, na.rm = TRUE)
  )


# é possível sumarizar várias colunas
pinguins %>%
  summarise(
    media_comprimento_nadadeira = mean(comprimento_nadadeira, na.rm = TRUE),
    media_comprimento_bico = mean(comprimento_bico, na.rm = TRUE),
    media_profundidade_bico = median(profundidade_bico, na.rm = TRUE)
  )


# GROUP_BY() + SUMMARISE()
# sumariza uma coluna agrupada por
# categorias de outra coluna

# calcula a média do ideb para cada categoria de ensino
pinguins %>%
  group_by(ilha) %>%
  summarise(
    media_massa_corporal = mean(massa_corporal, na.rm = TRUE)
  ) %>%
  arrange(desc(media_massa_corporal))


# a única mudança que a função group_by() faz na base
# é a marcação de que a base está agrupada
pinguins %>%
  group_by(ilha)


# RELOCATE()
# reordena as colunas por nome ou posição
pinguins %>%
  relocate(sexo, ano, .after = ilha)


# RENAME()
# renomeia as colunas de uma tabela
pinguins %>%
  rename(
    comprimento_bico_mm = comprimento_bico,
    profundidade_bico_mm = profundidade_bico,
    comprimento_nadadeira_mm = comprimento_nadadeira,
    massa_corporal_g = massa_corporal
  )


# SLICE_HEAD()
# seleciona as primeiras linhas da tabela
pinguins %>%
  slice_head(n = 5)



# SLICE_MAX()
# seleciona linhas por valores de uma coluna
pinguins %>%
  slice_max(massa_corporal, n = 5)



# SLICE_SAMPLE()
# seleciona linhas aleatoriamente
pinguins %>%
  slice_sample(n = 20)


# DISTINCT()
# retira as linhas com valores duplicados
pinguins %>%
  distinct(massa_corporal, .keep_all = TRUE)


# COUNT()
# conta valores de uma coluna
pinguins %>%
  count(especie)

# conta valores de mais de uma coluna
pinguins %>%
  count(especie, ilha)


# BIND_ROWS()
# combina dados por linhas

# selecionar as linhas para dois tibbles
pinguins_01 <- slice(pinguins, 1:5) %>% select(1:3)
pinguins_02 <- slice(pinguins, 51:55) %>% select(4:6)

# combinar as linhas
bind_rows(pinguins_01, pinguins_02, .id = "id")


# BIND_COLS()
#combina dados por colunas

# selecionar as linhas para dois tibbles
pinguins_01 <- slice(pinguins, 1:5)
pinguins_02 <- slice(pinguins, 51:55)

## combinar as colunas
bind_cols(pinguins_01, pinguins_02, .name_repair = "unique")

# *_JOIN()
# combina pares de dados tabulares por uma ou mais chaves

# LEFT_JOIN()

# cria tabela com coordenadas das ilhas
pinguins_ilhas <- tibble(
  ilha = c("Torgersen", "Biscoe", "Dream", "Alpha"),
  longitude = c(-64.083333, -63.775636, -64.233333, -63),
  latitude = c(-64.766667, -64.818569, -64.733333, -64.316667))

pinguins_ilhas

# une as duas tabelas pela chave "ilha"
pinguins_left_join <- left_join(pinguins, pinguins_ilhas, by = "ilha")

glimpse(pinguins_left_join)



# Pacote tidyr ------------------------------------------------------------

# O pacote `tidyr` tem a função de tornar um conjunto de dados tidy (organizados),
# sendo esses fáceis de manipular, modelar e visualizar.

# - cada coluna é uma variável;
# - cada linha é uma observação;
# - cada célula é um único valor.


########################################################################
# As principais funções do tidyr são:
# unite(): junta dados de múltiplas colunas em uma
# separate(): separa caracteres em múlplica colunas
# separate_rows(): separa caracteres em múlplica colunas e linhas
# drop_na(): retira linhas com NA
# replace_na(): substitui NA
# pivot_wider(): long para wide
# pivot_longer(): wide para long
########################################################################


# UNITE()
# une duas colunas em uma única coluna

especie_ilha <- pinguins %>%
  unite(
    col = "especie_ilha",
    especie:ilha,
    sep = " - "
  )

head(especie_ilha)


# SEPARATE()
# separa uma coluna em duas ou mais colunas

especie_ilha %>%
  separate(
    col = especie_ilha,
    into = c("especie", "ilha"),
    sep = " - ",
  )


# DROP_NA()
# remove as linhas que contém NA de todas as colunas

pinguins %>%
  drop_na()


# PIVOT_LONGER()
# names_from: variável categórica que definirá os nomes das colunas
# values_from: variável numérica que preencherá os dados
# values_fill: valor para preencher os NAs

pivot_wider(data = penguins_raw[, c(2, 3, 13)],
            names_from = Species,
            values_from = `Body Mass (g)`)



# PIVOT_WIDER()
# names_to: nome da coluna que receberá os nomes
# values_to: nome da coluna que receberá os valores

pivot_longer(data = penguins_raw[, c(2, 3, 10:13)],
             cols = `Culmen Length (mm)`:`Body Mass (g)`,
             names_to = "medidas",
             values_to = "valores")
