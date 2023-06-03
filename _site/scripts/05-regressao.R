

# Pacotes necessários -----------------------------------------------------

# install.packages("wooldridge")

library(tidyverse)
# library(wooldridge)

# DADOS EDUCACIONAIS ------------------------------------------------------


# Importando os dados -----------------------------------------------------

# ideb_fundamental <-
#   read_csv("dados/educacionais/ideb_fundamental.csv",
#            col_types = cols(id_municipio = col_character(), ano = col_integer()))
#
# ideb_medio <-
#   read_csv("dados/educacionais/ideb_medio.csv",
#            col_types = cols(id_municipio = col_character(), ano = col_integer()))
#
# indicadores_fundamental <-
#   read_csv("dados/educacionais/indicadores_fundamental.csv",
#            col_types = cols(id_municipio = col_character(), ano = col_integer()))
#
# indicadores_medio <-
#   read_csv("dados/educacionais/indicadores_medio.csv",
#            col_types = cols(id_municipio = col_character(), ano = col_integer()))
#
# pib_pc <-
#   read_csv("dados/educacionais/pib_pc.csv",
#            col_types = cols(id_municipio = col_character(), ano = col_integer()))


head(ideb_fundamental, n = 5)

head(ideb_medio, n = 5)

head(indicadores_fundamental, n = 5)

head(indicadores_medio, n = 5)

head(pib_pc, n = 5)

## DICIONÁRIO

# BASES IDEB_FUNDAMENTAL E IDEB_MÉDIO
# 1. `id_municipio`: código do IBGE de identificação do município
# 2. `tx_aprov`: taxa de aprovação média do município
# 3. `ideb`: índice de desenvolvimento da educação básica
# - é calculado a partir dos dados de aprovação escolar (obtidos pelo Censo Escolar)
# e das médias de desempenho no Sistema de Avaliação da Educação Básica (Saeb)

# BASES INDICADORES_FUNDAMENTAL E INDICADORES_MÉDIO
# 1. `id_municipio`: código do IBGE de identificação do município
# 2. `tx_aband`: taxa de abandono escolar média do município
# 3. `hrs_aula`: média das horas de aula por município
# 4. `tdi`: taxa de distorção idade-série
# - proproção de alunos com mais de 2 anos de atraso escolar

# PIB
# 1. `id_municipio`: código do IBGE de identificação do município
# 2. `pib`: pib dos municípios em 2020
# 3. `populacao`: população dos municípios em 2020



# padronizando as bases

ideb_fundamental <- ideb_fundamental %>%
  select(id_municipio, tx_aprov, ideb)

# select(ideb_fundamental, id_municipio, tx_aprov, ideb)

ideb_fundamental


ideb_medio <- ideb_medio %>%
  select(id_municipio, tx_aprov, ideb)

ideb_medio


indicadores_fundamental <- indicadores_fundamental %>%
  select(id_municipio, tx_aband, hrs_aula, tdi)

indicadores_fundamental


indicadores_medio <- indicadores_medio %>%
  select(id_municipio, tx_aband, hrs_aula, tdi)

indicadores_medio


pib_pc <- pib_pc %>%
  mutate(pib_pc = round(pib/populacao, 2)) %>%  # cria a coluna pib_pc
  select(id_municipio, pib_pc)

pib_pc


### Juntando as bases de dados: Fundamental

# 2 left_join em sequencia
left_join(
  ideb_fundamental, indicadores_fundamental, by = "id_municipio"
) %>%
  left_join(pib_pc, by = "id_municipio")

# reduce
# PROGRAMAÇÃO FUNCIONAL - MAIS INDICADO!
fund <- list(ideb_fundamental, indicadores_fundamental, pib_pc) %>%
  reduce(left_join)

fund

### Análises Descritivas: Fundamental

summary(fund)

fund %>%
  ggplot() +
  aes(x = ideb) +
  geom_histogram()

fund %>%
  ggplot() +
  aes(x = ideb) +
  geom_boxplot()

### Regressão Linear: Fundamental

# Será que a `tdi` e a `tx_aband` possuem relação positiva?

fund %>%
  ggplot(aes(x = tdi, y = tx_aband)) +
  geom_point()


# Será que a `tdi` e a `tx_aband` possuem relação positiva?

modelo_1 <- lm(tx_aband ~ tdi, data = fund)
summary(modelo_1)


# Será que a `tdi` e a `tx_aband` possuem relação positiva?

# A relação entre `tdi` e `tx_aband` é positiva, mas não parece ser muito forte.

# tx_aband = -0.568 + 0.124tdi

# Interpretação:** O aumento de 1 p.p. na taxa de distorção idade-série (`tdi`)
# retorna um aumento de 0.12 p.p. na taxa de abandono escolar (`tx_aband`).

# Quanto maior a distorção idade-série (`dti`), maiores são as taxas de abandono escolar (`tx_aband`).


# Qual a relação entre `tdi`, `tx_aprov`, `hrs_aula` e a `tx_aband`?

modelo_2 <- lm(tx_aband ~ tdi + tx_aprov + hrs_aula, data = fund)
summary(modelo_2)

# Qual a relação entre `tdi`, `tx_aprov`, `hrs_aula` e a `tx_aband`?

# A taxa de distorção idade-série (`dti`) e as horas-aula (`hrs_aula`)
# possuem relação positiva em relação à taxa de abandono (`tx_aband`),
# sendo a primeira variável com significância estatística muito próxima de zero,
# ou seja, significativa estatisticamente, e a segunda variável significativa
# estatisticamente para 90%. A taxa de aprovação (`tx_aprov`) apresenta uma relação
# negativa com a taxa de abandono (`tx_aband`), sendo aquela estatisticamente significativa.

# tx_aband = 22.093 + 0.059 \text{tdi} - 0.228 \text{tx_aprov} + 0.04 \text{hrs_aula}

# Interpretação:**

# Um aumento de 1 p.p. na taxa de distorção idade-série (`tdi`)
# gera um aumento de 0.059 p.p. na taxa de abandono escolar (`tx_aband`), *ceteris paribus*.

# Um aumento de 1 p.p. na taxa de aprovação (`tx_aprov`) resulta em uma redução
# de 0.228 p.p. na taxa de abandono (`tx_aband`), *ceteris paribus*.

# Um aumento de 1 hora-aula (`hrs_aula`) resulta em um aumento de 0.04 p.p.
# na taxa de abandono escolar (`tx_aband`).

# Qual a relação entre `tdi`, `tx_aprov`, `pib_pc` e a `tx_aband`?**


modelo_3 <- lm(tx_aband ~ tdi + tx_aprov + pib_pc, data = fund)
summary(modelo_3)


# Qual a relação entre `tdi`, `tx_aprov`, `hrs_aula` e a `tx_aband`?**

modelo_2 <- lm(tx_aband ~ tdi + tx_aprov + hrs_aula, data = fund)
summary(modelo_2)


# Qual a relação entre `tdi`, `tx_aprov`, `hrs_aula` e a `tx_aband`?**

# A taxa de distorção idade-série (`dti`) e as horas-aula (`hrs_aula`)
# possuem relação positiva em relação à taxa de abandono (`tx_aband`),
# sendo a primeira variável com significância estatística muito próxima de zero,
# ou seja, significativa estatisticamente, e a segunda variável significativa
# estatisticamente para 90%. A taxa de aprovação (`tx_aprov`) apresenta uma
# relação negativa com a taxa de abandono (`tx_aband`), sendo aquela estatisticamente significativa.


# text{tx_aband} = 22.093 + 0.059 \text{tdi} - 0.228 \text{tx_aprov} + 0.04 \text{hrs_aula}

# **Interpretação:**

# Um aumento de 1 p.p. na taxa de distorção idade-série (`tdi`) gera
# um aumento de 0.059 p.p. na taxa de abandono escolar (`tx_aband`), *ceteris paribus*.

# Um aumento de 1 p.p. na taxa de aprovação (`tx_aprov`) resulta em uma redução
# de 0.228 p.p. na taxa de abandono (`tx_aband`), *ceteris paribus*.

# Um aumento de 1 hora-aula (`hrs_aula`) resulta em um aumento de 0.04 p.p. na
# taxa de abandono escolar (`tx_aband`).


# Qual a relação entre `tdi`, `tx_aprov`, `pib_pc` e a `tx_aband`?**

modelo_3 <- lm(tx_aband ~ tdi + tx_aprov + pib_pc, data = fund)
summary(modelo_3)


  # \text{tx_aband} = 22.438 + 0.056 \text{tdi} - 0.229 \text{tx_aprov} + 0.000004 \text{pib_pc}

# **Interpretação:**

# O pib *per capita* (`pib_pc`) possui uma relação negativa com a taxa de abandono
# escolar (`tx_aband`), isto é, quanto maior for o pib *per capita* do município,
# menor será a taxa de abandono escolar.

# O aumento de 1 Real no pib *per capita* gera uma queda de 0.000004 p.p.
# na taxa de abandono escolar. Convertendo o valor do `pib_pc` para 10 mil Reais,
# isso corresponde a um decréscimo de 0.04 p.p. na taxa de abandono escolar.

# Isso indica que municípios mais ricos possuem valores consideravelmente menores
# de abandono escolar quando comparados com municípios mais pobres, *ceteris paribus*.

---

  ### Juntando as bases de dados: Médio


left_join(
  ideb_medio, indicadores_medio, by = "id_municipio"
) %>%
  left_join(pib_pc, by = "id_municipio")


# PROGRAMAÇÃO FUNCIONAL - MAIS INDICADO!
medio <- list(ideb_medio, indicadores_medio, pib_pc) %>%
  reduce(left_join)


  ### Análises Descritivas: Médio


summary(medio)


medio %>%
  ggplot() +
  aes(x = ideb) +
  geom_histogram()


medio %>%
  ggplot() +
  aes(x = ideb) +
  geom_boxplot()



  ### Regressão Linear: Médio

  # **Qual a relação entre o `ideb` e a `tx_aband`?**


medio %>%
  ggplot(aes(x = ideb, y = tx_aband)) +
  geom_point() # +
# geom_smooth(method = "lm", se = FALSE)

# Quanto maior o ideb, menor é a taxa de abandono. Relaçào forte com a queda na taxa de abandono.



  # **Qual a relação entre a `tx_aprov` e a `tx_aband`?**


medio %>%
  ggplot(aes(x = tx_aprov, y = tx_aband)) +
  geom_point() # +
# geom_smooth(method = "lm", se = FALSE)




  **Qual a relação entre a `hrs_aula` e a `tx_aband`?**


  ```{r}
medio %>%
  ggplot(aes(x = hrs_aula, y = tx_aband)) +
  geom_point() # +
# geom_smooth(method = "lm", se = FALSE)


  ```{r}
modelo_4 <- lm(tx_aband ~ tx_aprov + tdi + hrs_aula + pib_pc, data = medio)
summary(modelo_4)


# tx_aband} = 49.94 - 0.504 tx_aprov} + 0.093 \text{tdi} - 0.136 \text{hrs_aula} - 0.00001\text{pibpc}

  # **Interpretação:**

  # O aumento de 1 p.p. na taxa de aprovação (`tx_aprov`) reduz em 0.50 p.p.
# a taxa de abandono escolar (`tx_aband`), *ceteris paribus*.

# O aumento de 1 p.p. na taxa de distorção idade-série (`tdi`) aumenta em 0.082 p.p.
# a taxa de abandono escolar (`tx_aband`), *ceteris paribus*.

# O aumento de 1 hora-aula (`hrs_aula`) diminui em 0.136 p.p. a taxa de
# abandono escolar (`tx_aband`), *ceteris paribus*.

# O aumento de 1 Real no pib *per capita* gera uma queda de 0.00001 p.p. na taxa
# de abandono escolar, *ceteris paribus*. Convertendo o valor do `pib_pc`
# para 10 mil Reais, isso corresponde a uma redução de 0.1 p.p. na taxa de
# abandono escolar, *ceteris paribus*.

# Quanto mais tempo o adolescente passa na escola, menor é a queda na taxa de
# abandono escolar. As taxas de abandono no ensino médio são maiores quando
# comparado com o ensino fundamental. O pib *per capita* afeta mais os dados do
# ensino médio do que do ensino fundamental.



# Base dos Dados


# install.packages("basedosdados")

library(basedosdados)

# faz a ligação entre o R e a BigQuery do Google
set_billing_id("luisagisele")



# sem filtro
"SELECT coluna1, coluna2, coluna3,
coluna4 AS apelido_da_coluna
FROM `tabela`"

# com filtro
"SELECT coluna1, coluna2, coluna3,
coluna4 AS apelido_da_coluna
FROM `tabela`
WHERE coluna1 = valor AND coluna2 = valor"



# Atlas do Desenvolvimento Humano



  ### Importando os dados


adh <-
  "SELECT id_municipio, ano, mortalidade_1, mortalidade_5, taxa_freq_liquida_pre, indice_gini,
prop_pobreza_extrema_criancas, prop_pobreza_criancas, prop_vulner_pobreza_criancas, taxa_agua_esgoto_inadequados, taxa_criancas_fora_escola_4_5
FROM `basedosdados.mundo_onu_adh.municipio`"




adh <-
  "SELECT id_municipio, ano, mortalidade_1, mortalidade_5, taxa_freq_liquida_pre, indice_gini,
prop_pobreza_extrema_criancas, prop_pobreza_criancas, prop_vulner_pobreza_criancas, taxa_agua_esgoto_inadequados, taxa_criancas_fora_escola_4_5
FROM `basedosdados.mundo_onu_adh.municipio`" %>%
  read_sql()


glimpse(adh)



# Será que a mortalidade infantil de crianças até 1 ano se relaciona
# com a taxa de água e esgoto inadequados?**


adh %>%
  ggplot() +
  aes(x = taxa_agua_esgoto_inadequados, y = mortalidade_1) +
  geom_point()


# Parece ter relação, mas não muito forte. Os pontos parecem espalhados

---

  # **Comparação entre a proporção de extrema pobreza em crianças e a mortalidade infantil**

  ```{r}
adh %>%
  ggplot() +
  aes(x = prop_pobreza_extrema_criancas, y = mortalidade_5) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
```

# Visualmente, parece ter uma relação positiva.

---

  # **Em relação ao slide anterior, será que há um padrão regional?**

  # Primeiro é preciso baixar os dados referentes as regiões do Brasil:

  ```{r}
regiao <-
  "SELECT id_municipio, nome_regiao
FROM `basedosdados.br_bd_diretorios_brasil.municipio`" %>%
  read_sql()
```

# Depois, faz um `left_join()` com a base `adh`:

  ```{r}
dados <- left_join(adh, regiao, by = "id_municipio")
```

# Agora, a base `dados` tem os dados de `adh` + os dados de `regiao``

```{r}
glimpse(dados)
```

---

  # **Em relação ao slide anterior, será que há um padrão regional?**

  ```{r}
dados %>%
  ggplot() +
  aes(x = prop_pobreza_extrema_criancas, y = mortalidade_5, color = nome_regiao) +
  geom_point() +
  scale_color_brewer(palette = "Set2")
```

# Municípios do Norte e Nordeste possuem altos índices de mortalidade infantil
# até 5 anos e com altos índices de pobreza extrema entre crianças.

---

  ## Paleta de Cores

  ```{r}
RColorBrewer::display.brewer.all()
```

---

  # **Relação entre crianças fora da escola (4 e 5 anos) e a proporção de crianças na extrema pobreza**

  ```{r}
dados %>%
  ggplot() +
  aes(x = prop_pobreza_extrema_criancas, y = taxa_criancas_fora_escola_4_5, color = nome_regiao) +
  geom_point() +
  scale_color_brewer(palette = "Set2") +
  # faz regressão para da regiao
  geom_smooth(method = "lm")
```

# É possível ver que algumas regiões têm uma relação mais inclinada que outras.
# Por exemplo, um aumento na taxa de pobreza extrema das crianças gera aumentos
# muito mais fortes na taxa de crianças fora da escola na região sul do que no nordeste.

---

  ```{r}
dados %>%
  group_by(ano, nome_regiao) %>%
  summarise(media = mean(mortalidade_1, na.rm = TRUE)) %>%
  ggplot() +
  aes(x = media, y = nome_regiao, color = as.factor(ano)) +
  geom_point(size = 4)
```

```{r}
dados %>%
  group_by(ano, nome_regiao) %>%
  summarise(media = mean(mortalidade_1, na.rm = TRUE)) %>%
  ggplot() +
  aes(x = nome_regiao, y = media, fill = as.factor(ano)) +
  # indica como as barras devem ser posicionadas
  geom_bar(stat = "identity", position = "dodge")
```

---

  ### MAPAS

  ```{r}
library(geobr)
muni <- read_municipality(year = 2010)

muni <- muni %>%
  mutate(code_muni = as.character(code_muni))

dados_final <- left_join(muni, dados, by = c("code_muni" = "id_municipio"))

glimpse(dados_final)
```

---

  ```{r}
dados_final %>%
  filter(ano == 2010) %>%
  ggplot() +
  geom_sf(aes(geometry = geom, fill = mortalidade_1), color = NA)


### Pacote `{wooldridge}`

```{r}
wage <- wooldridge::wage1

wage

# tenure quanto tempo a pessoa tá na empresa

lm(formula = y ~ x, data = )
mod <- lm(wage ~ educ, data = wage)
summary(mod)



wage %>%
  ggplot() +
  aes(x = educ, y = wage) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)


# WAGE = -0.91 + 0.54EDUC
# a cada 1 ano que aumenta educ, o salário aumento (em média) 54 centavos de dólar


wage %>%
  ggplot() +
  aes(x = educ, y = lwage) +
  geom_point()+
  geom_smooth(method = 'lm', se = FALSE)


mod1 <- lm(lwage ~ educ, data = wage)
summary(mod1)

# LWAGE = 0.58 + 0.0827EDUC
# a cada 1 ano de educacao, o salário aumenta 8.27% (beta * 100)

ggplot(wage) +
  aes(x = educ, y = lwage, size = exper) +
  geom_point()


# mincer: o salario da pessoa pode ser estimado por meio da sua experiencia e da sua educacao

mincer <- lm(lwage ~ educ + exper, data = wage)
summary(mincer)

# lwage = 0.2169 + 0.0979 educ + 0.010 exper
#  aumento de 1 ano em educacao gera um aumento de 9,79% salario


mincer2 <- lm(lwage ~ educ + exper + expersq, data = wage)
summary(mincer2)

# conforme a experiencia aumenta, ela afeta negativamente o salario da pessoa

#lwage = 0.12 + 0.09educ + 0.041exper - 0.00071expersq
