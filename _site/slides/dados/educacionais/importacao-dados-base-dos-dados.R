
# Baixando os dados da Base dos Dados -------------------------------------

library(magrittr)

basedosdados::set_billing_id("luisagisele")

# IDEB

ideb <-
"
SELECT
id_municipio,
ano,
AVG(taxa_aprovacao) as tx_aprov,
ensino,
AVG(ideb) as ideb
FROM `basedosdados.br_inep_ideb.municipio`
WHERE ano = 2021
GROUP BY id_municipio, ano, ensino
" %>%
  basedosdados::read_sql()

ideb_fundamental <- ideb %>%
  dplyr::filter(ensino == "fundamental")

ideb_medio <- ideb %>%
  dplyr::filter(ensino == "medio")


# INDICADORES

indicadores_fundamental <-
"
SELECT
ano, id_municipio,
AVG(taxa_abandono_ef) as tx_aband,
AVG(had_ef) as hrs_aula,
AVG(tdi_ef) as tdi
FROM `basedosdados.br_inep_indicadores_educacionais.municipio`
WHERE ano = 2021
GROUP BY id_municipio, ano
" %>%
  basedosdados::read_sql()


indicadores_medio <-
"
SELECT
ano, id_municipio,
AVG(taxa_abandono_em) as tx_aband,
AVG(had_em) as hrs_aula,
AVG(tdi_em) as tdi
FROM `basedosdados.br_inep_indicadores_educacionais.municipio`
WHERE ano = 2021
GROUP BY id_municipio, ano
" %>%
  basedosdados::read_sql()


# PIB

pib <-
"
SELECT id_municipio, ano, pib
FROM `basedosdados.br_ibge_pib.municipio`
WHERE ano = 2020
" %>%
  basedosdados::read_sql() %>%
  dplyr::mutate(pib = as.numeric(pib))


# POPULACAO

populacao <-
"
SELECT id_municipio, ano, populacao
FROM `basedosdados.br_ibge_populacao.municipio`
WHERE ano = 2020
" %>%
  basedosdados::read_sql() %>%
  dplyr::mutate(populacao = as.numeric(populacao))


# PIB_PC

pib_pc <- dplyr::left_join(pib, populacao, by = c("id_municipio", "ano"))


# REGIÕES

regiao <-
"
SELECT id_municipio, nome_regiao
FROM `basedosdados.br_bd_diretorios_brasil.municipio`
" %>%
  basedosdados::read_sql()



# SALVANDO EM .csv --------------------------------------------------------

readr::write_csv(ideb_fundamental, "dados/ideb_fundamental.csv")
readr::write_csv(ideb_medio, "dados/ideb_medio.csv")
readr::write_csv(indicadores_fundamental, "dados/indicadores_fundamental.csv")
readr::write_csv(indicadores_medio, "dados/indicadores_medio.csv")
readr::write_csv(pib_pc, "dados/pib_pc.csv")
readr::write_csv(regiao, "dados/regiao.csv")
