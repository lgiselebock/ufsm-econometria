
library(tidyverse)


# importa a base  ---------------------------------------------------------

pinguins <- read_csv("dados/pinguins/pinguins.csv")


# Camadas dos gráficos ----------------------------------------------------

cars %>%
  ggplot()

cars %>%
  ggplot() +
  aes(x = speed, y = dist)

cars %>%
  ggplot() +
  aes(x = speed, y = dist) +
  geom_point()



cars %>%
  ggplot() +
  aes(x = speed, y = dist) +
  geom_point(color = "darkblue") +
  geom_smooth(se = FALSE, color = "darkgrey", method="lm", formula = "y~x") +
  labs(
    title = "A velocidade influencia na distância de parada?",
    subtitle = "Distância necessária para parar o carro",
    caption = "Fonte: Ezekiel, M. (1930) Methods of Correlation Analysis. Wiley",
    x = "Velocidade",
    y = "Distância para parar"
  ) +
  theme_minimal()



# Gráfico de dispersão (pontos) -------------------------------------------

pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point()


# adiciona uma linha de tendência
pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point() +
  geom_smooth(method = "lm", formula = "y ~ x", se = FALSE)


# importante notar como a ordem das camadas
# é importante na construção de um gráfico
pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_smooth(method = "lm", formula = "y ~ x", se = FALSE) +
  geom_point()

# adição de mais um atributo para ser mapeado
pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point(aes(color = especie))


pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point(aes(color = especie, shape = sexo))


# Gráfico de linhas -------------------------------------------------------

pinguins %>%
  group_by(ano) %>%
  summarise(
    massa_corporal_media = mean(massa_corporal, na.rm = TRUE)
  ) %>%
  ggplot() +
  geom_line(aes(x = ano, y = massa_corporal_media))


# linhas + pontos no mesmo gráfico
pinguins %>%
  group_by(ano) %>%
  summarise(
    massa_corporal_media = mean(massa_corporal, na.rm = TRUE)
  ) %>%
  ggplot() +
  geom_line(aes(x = ano, y = massa_corporal_media)) +
  geom_point(aes(x = ano, y = massa_corporal_media))


# mais de um geom, pode ser interessante definir
# os atributos no aes() do ggplot()
pinguins %>%
  group_by(ano) %>%
  summarise(
    massa_corporal_media = mean(massa_corporal, na.rm = TRUE)
  ) %>%
  ggplot(aes(x = ano, y = massa_corporal_media)) +
  geom_line() +
  geom_point()


# se geom precisar de atributo que os outros não precisam
# esse atributo é especificado dentro da função aes() do próprio geom
pinguins %>%
  group_by(ano) %>%
  summarise(
    massa_corporal_media = round(mean(massa_corporal, na.rm = TRUE), 2)
  ) %>%
  ggplot(aes(x = ano, y = massa_corporal_media)) +
  geom_line() +
  geom_label(aes(label = massa_corporal_media))


# Gráfico de barras -------------------------------------------------------

pinguins %>%
  count(especie) %>%
  ggplot() +
  geom_col(aes(x = especie, y = n))


# adicionando cores nas barras
# importante notar que o argumento é fill =
# nesse caso, o argumento color = colore apenas as bordas das barras
pinguins %>%
  count(especie) %>%
  ggplot() +
  geom_col(
    aes(x = especie, y = n, fill = especie),
    show.legend = FALSE
  )



# inverte os eixos do gráfico
# constrói barras horizontais
pinguins %>%
  count(especie) %>%
  ggplot() +
  geom_col(
    aes(x = especie, y = n, fill= especie),
    show.legend = FALSE
  ) +
  coord_flip()


# para ordenar colunas para fator: fct_reorder()
pinguins %>%
  count(especie) %>%
  mutate(especie = forcats::fct_reorder(especie, n)) %>%
  ggplot() +
  geom_col(
    aes(x = especie, y = n, fill= especie),
    show.legend = FALSE
  ) +
  coord_flip()


# adiciona label em cada barra
pinguins %>%
  count(especie) %>%
  mutate(especie = forcats::fct_reorder(especie, n)) %>%
  ggplot() +
  aes(x = especie) + #<< # atributo espécie é comum a todos geoms
  geom_col(aes(y = n, fill= especie), show.legend = FALSE) +
  geom_label(aes(y = n/2, label = n)) +
  coord_flip()



# Histogramas -------------------------------------------------------------

# úteis para avaliar a distribuição de uma variável
pinguins %>%
  filter(especie == "Pinguim-de-adélia") %>%
  ggplot() +
  geom_histogram(aes(x = massa_corporal))


# binwidth = define o tamanho de cada intervalo
pinguins %>%
  filter(especie == "Pinguim-de-adélia") %>%
  ggplot() +
  geom_histogram(aes(x = massa_corporal),
                 # define o tamanho de cada intervalo
                 binwidth = 100,
                 # altera a cor das fordas de cada coluna
                 color = "white")


# Boxplot -----------------------------------------------------------------

# importantes para comparar várias distribuições
pinguins %>%
  ggplot() +
  aes(x = especie, y = comprimento_nadadeira) +
  geom_boxplot(aes(color = especie), show.legend = FALSE)



# Títulos, labels e escalas -----------------------------------------------

# labs() coloca títulos no gráfico/altera labels dos atritubos
# scale_* altera as escalar (textos e quebras) dos gráficos
# coord_cartesian() defina a porção do gráfico que deve ser mostrada

# adicionando títulos e labels
pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point(aes(color = especie)) +
  labs(x = "Comprimento da nadadeira (mm)", y = "Massa corporal (mm)",
       color = "Espécies", title = "Gráfico de dispersão",
       subtitle = "Comprimento da nadadeira vs Massa corporal",
       caption = "{palmerpenguins}")


# alterando as quebras dos eixos x e y
pinguins %>%
  group_by(ano) %>%
  summarise(
    massa_corporal_media = mean(massa_corporal, na.rm = TRUE)
  ) %>%
  ggplot() +
  geom_line(aes(x = ano, y = massa_corporal_media)) +
  scale_x_continuous(breaks = seq(2007, 2009, 1)) +
  scale_y_continuous(breaks = seq(4000, 4250, 25))



# Cores -------------------------------------------------------------------

# scale_color_manual() e scale_fill_manual() escole manualmente as cores do gráfico
# scale_color_discrete() e scale_fill_discrete() troca o nome nas legendas geradas

# substituindo as cores
pinguins %>%
  count(especie) %>%
  mutate(especie = forcats::fct_reorder(especie, n)) %>%
  ggplot() +
  aes(x = especie, y = n) +
  geom_col(aes(fill= especie), show.legend = FALSE)+
  coord_flip() +
  scale_fill_manual(values = c("red", "blue", "purple"))


# também pode usar códigos hexadecimais
pinguins %>%
  count(especie) %>%
  mutate(especie = forcats::fct_reorder(especie, n)) %>%
  ggplot() +
  aes(x = especie, y = n) +
  geom_col(aes(fill= especie), show.legend = FALSE)+
  coord_flip() +
  scale_fill_manual(values = c("#ff0000", "#0000ff", "#a020f0"))


# adiciona transparência (alpha)
# o argumento position = "identity" mantem as variáveis na ordem
pinguins %>%
  ggplot(aes(x = comprimento_nadadeira)) +
  geom_histogram(aes(fill = especie),
                 alpha = 0.5, position = "identity") +
  scale_fill_manual(values = c("darkorange","purple","cyan4")) +
  labs(x = "Comprimento da nadadeira (mm)", y = "Frequência",
       title = "Comprimento da nadadeira dos Pinguins") +
  theme_minimal()


pinguins %>%
  ggplot() +
  aes(x = especie, y = comprimento_nadadeira, color = especie) +
  geom_boxplot(width = 0.3, show.legend = FALSE) +
  geom_jitter(alpha = 0.5, show.legend = FALSE,
              position = position_jitter(width = 0.2, seed = 0)) +
  scale_color_manual(values = c("darkorange","purple","cyan4")) +
  labs(x = "Espécies", y = "Comprimento da nadadeira (mm)") +
  theme_minimal()


# Paletas de cores prontas:
# Escalas qualitativas: utilizado para variáveis nominais (sexo, cor/raça)
# Escalas divergenstes: utilizado para variáveis que têm um centro neutro
# (favorável/neutro/desfavorável, correlação)
# Escalas sequenciais: utilizado para variáveis ordinais (faixa etária, renda)
# Viridis muito últil para comunicar com pessoas com daltonismo

# Paletas de cores no ggplot2:
# scale_*_brewer(): utilizada para variáveis discretas.
# Possui três tipos: divergente, qualitativa e sequencial.
# scale_*_distiller(): utilizada para variáveis contínuas.
# Interpola as cores do brewer para lidar com todos os valores.
# scale_*_fermenter(): utilizada para variáveis contínuas,
# que são transformadas em discretas (binned).
# scale_*_viridis_[cdb]: Escala viridis para variáveis contínuas, discretas ou binned.
# scale_*_manual(): inclui um conjunto de cores manualmente.

# Paletas de outros pacotes:
# {ggthemr} tem um monte de paletas, mas está um pouco desatualizado.
# {hrbrthemes} contém uma lista de temas escolhidos pelo Bob Rudis.
# {ghibli} tem paletas de cores relacionadas ao Studio Ghibli.
# {paletteer} tem uma coleção de cores de vários outros pacotes de paletas.
# {RColorBrewer} tem uma coleção de paletas
# (sequenciais, qualitativas e divergentes) para gráficos e mapas.



# Trocando os textos da legenda -------------------------------------------

pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point(aes(color = especie)) +
  scale_color_discrete(
    labels = c(
      "Pinguim de Adelia", "Pinguim de Barbicha", "Pinguim Gentoo"
    )
  )



# Temas -------------------------------------------------------------------

# função theme_*()
# é possível criar temas próprios usando a função theme()

# tema padrão
pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point()

# tema bw
pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point() +
  theme_bw()

# tema classic
pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point() +
  theme_classic()

# tema light
pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point() +
  theme_light()

# thema minimal
pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point() +
  theme_minimal()

# tema void - interessante para mapas
pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point() +
  theme_void()

# tema dark
pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point() +
  theme_dark()


# criando um próprio tema
pinguins %>%
  ggplot() +
  aes(x = comprimento_nadadeira, y = massa_corporal) +
  geom_point(aes(color = especie)) +
  labs(title = "Gráfico de dispersão",
       subtitle = "Comprimento da nadadeira vs Massa corporal") +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title = element_text(color = "red"),
        panel.background = element_rect(fill = "lightgrey"),
        panel.grid = element_blank())
