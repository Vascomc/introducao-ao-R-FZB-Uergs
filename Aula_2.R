##################################################################
# PPGSCBio: Mestrado em Sistemática e Conservação da Diversidade Biológica Uergs/SEMA-RS
# Introdução ao R
# Prof. Dr. Márlon de Castro Vasconcelos
# Aula 2: 17/02/2021
##################################################################
# 1. Falando sobre Scripts
# 2. Criando um Projeto
# 3. Pacotes
#    a. tidyverse
#    b. rstatix
#    c. ggpubr
# 4. Usando o Pipe
# 5. Manipulando Dados
# 6. Manipulando Fatores
# 7. Gráficos com o GGPlot2
##################################################################
# 1. Script
#    Arquivo/Janela que contêm uma série de comandos para realização de procedimentos.
#    Importante criar um cabeçalho para o Script, contendo o "assunto" que será abordado.
#    Comentários são importantes principalmente ao compartilhar scripts.
#    Usamos o '#' Para adicionar comentários. Importante para descrever os passos de uma análise; sequência de um estudo, etc.
#    Oragnizando o script
#      Addins > style active file
#----------------------
# 2. Projeto
#    Criando um projeto
#    Fechando um projeto
#----------------------
# 3. Pacotes
#    Instalando
#    1. install.packages()
install.packages("tidyverse")

install.packages(c("tidyverse", "rstatix", "ggpubr"))

#    2. Painel Packages
#----------------------
#    3. Caregando um Pacote
library(tidyverse) 
require(tidyverse)
# Tanto Faz.
# para acessar as funções de um pacote SEMPRE temos que carregar o pacote.

# Ou podemos chamar o pacote junto com a função. Nesse caso tem-se que saber o nome do pacote e da função que se quer.
head(iris |> dplyr::filter(Species == "setosa"))

# Nesse exemplo o dplyr "está dentro do tidyverse". Eu prefiro carregar o pacote do que usar a notação  pacote::função(). Mas isso é gosto e a forma na qual se aprendeu, etc.
# A notação  pacote::função()  é interessante quando se tem funções com o mesmo nome e se quer usar a função de um pacote em específico.
#----------------------
# 4. Uso do PIPE 
#    Pipe foi introduzido junto com o pacote tidyverse %>%.
#    - Revolução na forma de escrever os códigos;
#    - Ele pega um resultado e "joga" na função seguinte, ...
#    - A partir do R 4.0 temos um pipe nativo. |> esse é mais rápido se comparado ao %>%.
#----------------------
# 5. Manipulando dados 
#    Manipulamos dados para deixr em formatos específicos para determinadas análises, obter um resumo estatístico, etc. Usaremos o tidyverse e o rstatix. 

# "Formatos de dados"
# Wide: Dados no formato curto
# long"Dados no formato longo


# Usemos os dados fish_encounters

glimpse(fish_encounters)
head(fish_encounters) # Dados no formato longo

peixes <- fish_encounters |> pivot_wider(names_from = station, values_from = seen)

head(peixes)

peixes <- fish_encounters |> pivot_wider(names_from = station, values_from = seen, values_fill = 0)

head(peixes)

# Caminho inverso. 
head(iris)

# Vamos supor que queremos plotar as variáveis ao mesmo tempo. No formato atual é bem complicado de fazer. Mas se colocarmos no formato longo, resolvemos o problema.

df <- iris |> pivot_longer(!Species, names_to = "medida", values_to= "Valores")

head(df)

# Agora podemos plotar as 4 variáveis de uma vez
ggpub::ggboxplot(df, x = "Species", y = "medidas")

df <- iris |> pivot_longer(cols = ends_with(".Length"), names_to = "medida", values_to= "Valores")

head(df)

# Outro Exemplo
head(billboard)
head(
billboard %>% 
 pivot_longer(
  cols = starts_with("wk"), 
  names_to = "week", 
  values_to = "rank",
  values_drop_na = TRUE)
)

# Colocando Week como uma variável inteira, pois ela está como Caracter.

head(
 billboard %>% 
  pivot_longer(
   cols = starts_with("wk"), 
   names_to = "week",
   names_prefix = "wk", # Retira o "wk" dos valores.
   names_transform = list(week = as.integer),
   values_to = "rank",
   values_drop_na = TRUE)
)

# Reumos estatísticos
library(rstatix)

# Dados Iris

iris |> freq_table(Species, Sepal.Width)
iris |> group_by(Species) |> get_summary_stats()
iris |> group_by(Species) |> get_summary_stats(type = "mean_sd")

# Modificando Variáveis

head(
iris |> group_by(Species) |>
 mutate_all(log1p)
)

# Usando o Summarise_
head(
 iris |> group_by(Species) |>
  summarise_all(mean)
)

head(
 iris |> group_by(Species) |>
  summarise_all(median)
)

head(
 iris |> group_by(Species) |>
  summarise_all(sd)
)

# Filtrando os dados
summary(
 iris |> filter(Species == "setosa")
)

# Selecionando variáveis
head(
  iris |> select (Sepal.Width, Sepal.Length)
)

# Filtrando e Selecionando
head(
  iris |> filter (Species == "virginica") |>
    select (Sepal.Width, Sepal.Length)
)

# Filtrando, Selecionando e "resumindo"
head(
  iris |> filter (Species == "virginica") |>
    select (Sepal.Width, Sepal.Length) |>
    summarise_all(mean)
)

# Renomeando
head(
  iris |> filter (Species == "virginica") |>
    select (Sepal.Width, Sepal.Length) |>
    summarise_all(mean) |>
    rename(Largura.Sépala = Sepal.Width,
           Comprimento.Sépala = Sepal.Length)
)

head(
  iris |> filter (Species == "virginica") |>
    select (Sepal.Width, Sepal.Length) |>
    summarise_all(mean) |>
    rename(Largura.Sépala = Sepal.Width,
           Comprimento.Sépala = Sepal.Length) |>
    rename_with(toupper)
)
a <-iris |> filter (Species == "virginica") |>
  select (Sepal.Width, Sepal.Length) |>
  summarise_all(mean) |>
  rename(Largura.Sépala = Sepal.Width,
         Comprimento.Sépala = Sepal.Length) |>
  rename_with(toupper)

a |> rename_with(tolower)
a |> rename_with(tolower, starts_with("Largura"))
a |> rename_with(~tolower(gsub(".","_", .x, fixed = T)))

# Quando os dados possuem nomes duplos e são separados por espaço
b <- a |> rename_with(~tolower(gsub("."," ", .x, fixed = T)))
b
b |> rename_with(~tolower(gsub(" ","_", .x, fixed = T)))
b |> rename_with(~toupper(gsub(" ","_", .x, fixed = T)))
#----------------------
# 6. Manipulando Fatores
#    - Pacote Forcats. Dentro do tidyverse

# Vamos usar o Species do Iris
attach(iris)

levels(Species)
# Mostra os níveis e a ordem com que aparecerão num gráfico. O R sempre usará por padrão ordens númericas e alfab éticas.

plot(Species, Sepal.Length)

# Mostra quantas amostras em cada fator
fct_count(Species)
summary(Species)

# Ordenando os fatores 
glimpse(iris)
a <- fct_relevel(Species, c("virginica","setosa","versicolor"))
plot(a, Sepal.Length)

# Ordenando pela relação entre as variáveis
plot(Sepal.Width ~ fct_reorder(Species, Sepal.Width))
plot(Sepal.Width ~ fct_reorder(Species, Sepal.Width,
                               .fun = mean, # Usa a média
                               .desc = T) # Descendente = Verdadeiro
     )

# Mudando o nome, valor dos níveis do Fator
fct_recode(Species, Sp1 = "setosa", Sp2 = "versicolor", Sp3 = "virginica")

# Quando filtramos os dados teremos níveis que não são usados. Podemos retirar esses níveis.

summary(
  iris |> filter(!Species == "setosa") # Exceto quando Espécie = setosa
)

a <-  iris |> filter(!Species == "setosa") 
summary(a)

a$Species <- fct_drop(a$Species) # "Dropando" e subscrevendo na mesma variável no meu conjunto de dados
summary(a)

# Lidando com NA

peixes <- fish_encounters |> pivot_wider(names_from = station, values_from = seen)

# Vamos supor que o conjunto Peixes veio com dados faltantes NA
head(peixes)

###################################
# Aqui é importante pensar na natureza dessa informação. Faltante por que não existe a espécie no local X, ou por quê o valor não pode ser obtido (valor abaixo do limite de detecção; < LDQ).
###################################

# Se tiver fator no conjunto de dados
glimpse(peixes)
peixes_1 <- peixes |> mutate(
  across(
    everything(), ~ replace_na(.x,0)
        )
)

anyNA(peixes_1)

# Se não tiver fator
peixes_2 <- peixes |> select(!fish)
glimpse(peixes_2)

peixes_2 <- peixes_2 |> mutate_all(replace_na, 0)
anyNA(peixes_2)

# Juntando conjuntos de dados. 
#   1. Usando _join
#   2. Aqui é importante que as duas bases tenham a mesma variável codificada. EX.: Códico de local de amostragem.

dados_1 <- data.frame(list(
  Locais = c(1:20),
  OD = rnorm(20, 6, 0.5),
  temp = rnorm(20, 23, 1),
  pH = rnorm(20, 7, 0.2),
  Cond = rnorm(20, 50, 30)
))
head(dados_1)

dados_2 <- data.frame(list(
  Locais = c(1:20),
  Sp1 = rpois(20, 2),
  Sp2 = rpois(20, 5),
  Sp3 = rpois(20, 10),
  Sp4 = rpois(20, 13),
  Sp5 = rpois(20, 13),
  Sp6 = rpois(20, 1),
  Sp7 = rpois(20, 0.5),
  Sp8 = rpois(20, 4)
))
head(dados_2)

# Vamos supor que eu quero enviar esses dados para um pesquisador. Mas quero na mesma planilha

dados_junto <- full_join(dados_1, dados_2) 
head(dados_junto)

# OBS.: Temos outros _join, que juntam somente valores iguais, linhas iguais ou colunas iguais. No exemplo acima o full_join, mantêmm tudo, ficando apenas uma coluna com a variável de combinação que são os locais amostrados.

# Para Exportar
write.csv(dados_junto, "NOME_QUE_QUISER.csv")
# Salvara o arquivo .CSV na pasta do projeto que se está trabalhando.

#----------------------
# 7. Gráficos com o GGPlot2
#    1. O ggplot2 é um "raciocinio" para construção de gráficos. 
#    2. Extremamente customizável
#    3. Vários pacotes, mas vários mesmo, que trabalham com ele.
#       ex.: Mostrar minha lista de pacotes gg_
#   Como Funciona?
#   - Temos o básico que é o ggplot()
#   - Daí temos os aestetics, variável X e Y
#   - geom_ que são os tipos de gráficos
#   - Basicamente com isso já montamos um.

names(iris)
ggplot(iris, aes(x = Species, y = Sepal.Width)) +
  geom_boxplot() +
# Sempre acrescentamos informação ao gráfico com o +
  xlab("Espécies amostradas") +
  ylab("Largura de Sepala (cm)")


grafico_1 <- ggplot(iris, aes(x = Species, y = Sepal.Width)) +
  geom_boxplot()

grafico_1

grafico_1 <- grafico_1 + 
  xlab("Espécies amostradas") +
  ylab("Largura de Sepala (cm)")

grafico_1

# Adicinando mais coisas...
# a. Cores
grafico_1 + geom_boxplot(aes(fill = Species))

#   a.1. Escala de Cinza 
grafico_1 + geom_boxplot(aes(fill = Species)) +
  scale_fill_manual(values = c("gray15", "gray45", "gray75"))

#   a.2. Outra Escala de Cor
library(RColorBrewer)
display.brewer.all(n=NULL, 
                   type="all", 
                   select=NULL, 
                   exact.n=TRUE, 
                   colorblindFriendly=T)
# Mostra todas os "tipos" de cores
display.brewer.pal(11,'RdYlBu')
# Visualisar as cores na área do PLOT
brewer.pal(11,'RdYlBu')
# Código das cores observadas na área do PLOT

grafico_1 + geom_boxplot(aes(fill = Species)) +
  scale_fill_manual(values = c("#A50026", "#ABD9E9", "#313695"))

# b. Fundo
grafico_2 <- grafico_1 + geom_boxplot(aes(fill = Species)) +
  scale_fill_manual(values = c("#A50026", "#ABD9E9", "#313695"))

grafico_2
grafico_2 + theme_bw()
grafico_2 + theme_classic()
grafico_2 + theme_minimal()
grafico_2 + theme_gray()
grafico_2 + theme_void()

grafico_3 <- grafico_2 + theme_minimal()

grafico_3 + scale_fill_manual(values = c("#A50026", "#ABD9E9", "#313695"), name = "Espécies", labels = c("D", "E", "P"))

grafico_3 + guides(fill = "none") +
  theme(text=element_text(family="Times New Roman",
                          size = 14)) +
  theme(axis.text.x = element_text(color="black", size=14),
        axis.text.y = element_text(color="black", size=14))
                              
grafico_3 + guides(fill = "none") +
  theme(text=element_text(family="Times New Roman",
                          size = 14)) +
  theme(axis.text.x = element_text(color="black", size=14, face = "bold"),axis.text.y = element_text(color="black", size=14))   

# c. Gráfico de disperssão

f <- ggplot(iris, aes(Sepal.Length, Sepal.Width))
f
f <- f + geom_point() +
  labs(x = "Comprimento de Sépala (cm)", y = "Largura de Sépala (cm)", title = "Figura 1")

# Mudar a forma dos "pontos"
f + geom_point(aes(shape = Species))
f + geom_jitter(aes(shape = Species))

# d. Histograma
g <- ggplot(iris, aes(Sepal.Length))
g + geom_histogram(color = "white",
                   bins = 15 # N° de Barras, padrão = 30
                   )
# e. Densidade
g + geom_density()

# e. Área
g + geom_area(stat = "bin")

# Gráfico de Erro
df <- data.frame(grp = c("A", "B"), fit = 4:5, se = 1:2)
df
j <- ggplot(df, aes(grp, fit, ymin = fit-se, ymax = fit+se))
j + geom_errorbar()
j + geom_pointrange()

#----------------------
# Usando o ggpubr
# Mais interessante para usar

library(ggpubr)

ggboxplot(iris, x = "Species", y = "Sepal.Width")
ggerrorplot(iris, x = "Species", y = "Sepal.Width")
ggscatter(iris, x = "Sepal.Length", y = "Sepal.Width")

# Mudando os eixos
ggboxplot(iris, x = "Species", y = "Sepal.Width",
          xlab = "Espécies", ylab = "Largura da Sépala",
          fill = "Species",
        # fill = "gray",
        # palette = "Dark2"
        # palette = "RdYlBu"
        # palette = "jco",
        # add = "jitter", 
        # ggtheme = theme_bw(),
        # orientation = "horizontal",
        # order = c("versicolor", "virginica", "setosa")
        ) # +
#  theme(text=element_text(family="Times New Roman",
#                          size = 14)) +
#  theme(axis.text.x = element_text(color="black", size=14, face = "bold"),axis.text.y = element_text(color="black", size=14))   


# Gráfico com dois fatores
head(ToothGrowth)

ggboxplot(ToothGrowth, x = "dose", y = "len")
ggboxplot(ToothGrowth, x = "dose", y = "len", fill = "supp")


#   outra abordagem
ggboxplot(ToothGrowth, x = "supp", y = "len", facet.by = "dose")

ggscatter(iris, x = "Sepal.Length", y = "Sepal.Width", color = "Species")
# obs.: fill x color

######################### This is the End! ##########################