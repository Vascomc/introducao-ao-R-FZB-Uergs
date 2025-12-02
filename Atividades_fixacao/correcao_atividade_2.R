
###################
# Mestrado em Sistemática e Conservação da Biodiversidade
# Disciplina Introdução ao ambiente R
# Atividade 2
###################

# 3 Carregue os pacotes tidyverse, rstatix e ggpubr
# Carregando vários pacotes num comando.
pacman::p_load('tidyverse', 'rstatix', 'ggpubr')
pacman::p_load(tidyverse, rstatix, ggpubr)


# 4
# a) Copiar, colar e executar os comandos abaixo, o que está acontecendo em cada linha?
estagio <- gl(4, 20, labels = c("Climax", "Inicial","Medio_tardio", "Medio_inicial")) 
# Cria uma objeto/variável que é um fator com 4 níveis e 20 valores para cada nível
# sendo os níveis Climax, inicial, metio tardio, medio inicial
set.seed(1)
temp <- c(rnorm(20, 13, 2), rnorm(20, 30, 2), rnorm(20, 22, 2), rnorm(20, 25, 2))
# Cria uma variável temp a partir da função rnorm tendo 20 valores em 4 níveis conrespondentes
# à variável estagio
set.seed(1)
riqueza <- c(rpois(20, 20), rpois(20, 10), rpois(20, 18), rpois(20, 12))
# Similar à temp porém usando a distribuição de poisson.

df <- data.frame(estagio, temp, riqueza)
# Aqui cria um data frame (conjunto de dados) com as três variáveis criadas nos passos 
# anteriores.

head(df) # Chama o conjunto de dados mostrando as 6 primeiras linhas

a<-c(rep("A",20), rep("B",20), rep("C",20), rep("D",20))
df2 <- data.frame(estagio, temp, riqueza, as.factor(a))
# b) Examine o objeto df usando as funções summary(), str() e glimpse(). 
#    Para você, o que elas têm de diferente?
summary(df)
summary(df2)

str(df)
glimpse(df)

# c)
# i Crie um objeto com os dados apenas para o nível inicial
df_inicial <- df |> filter(estagio == "Inicial")
head(df_inicial)
summary(df_inicial)
# ii Crie um objeto com os dados para os níveis inicial e clímax
df2 <- df |> filter(estagio == "Inicial" | estagio == "Climax") # | significa 'ou'
df2$estagio <- fct_drop(df2$estagio)
summary(df2)

# iii Obtenha e salve em um objeto valores de riqueza quando a temperatura for maior que 25°C
df3 <- df |> select(riqueza, temp) |> filter(temp > 25)
df3 <- df |> select(riqueza) |> filter(temp > 25)
summary(df3)
# IV Obtenha o resumo estatístico para cada estágio sucessional. Copie e cole no Excel.
resumo <- df |> group_by(estagio) |>
 get_summary_stats(type = "common") # type "mean_sd", "mean_se", 
resumo
write_csv(resumo, "resumo.csv")

gtsummary::tbl_summary(resumo) # Organizar para a tabela ficar "bonitinha"

#=========================================================================
# TABELA BOMITINHA
df |> group_by(estagio) |> # Variável que quer agrupar
 get_summary_stats() %>%  # Gerar as estatísticas. Desse jeito peca o 'type = "full"'
 gt(groupname_col = "estagio", # Agrupa pela variável escolhda em 'group_by'
    row_group_as_column = TRUE  # Serve para deixar como apareceu aqui
 ) %>%
 tab_header( # Títulos da tabela
  title = md("**Diversidade**"),
  subtitle = md("Descreve a diversidade por estágios sucessuionais.")
 ) %>% 
 cols_label( # Nomes das colunas. Aqui precisa cuidar as estatiticas em 'type'
  variable = md("Variáveis"),
  n = md("(n)"),
  min = md("Min"),
  max = md("Max"),
  median = md("Mediana"),
  q1 = md("Q1"),
  q3 = md("Q3"),
  iqr = md("IQR"),
  mad = md("MAD"), # Desvio Absoluto da Mediana
  mean = md("Média"),
  sd = md("DP"),
  se = md("EP"),
  ci = md("IC")
 ) %>%  
 opt_align_table_header(align = "center") %>%  # alinhamento 
 tab_source_note(
  source_note = md("*Dados obtidos a partir de dados criados.*")
 ) %>% 
 tab_footnote(
  footnote = "Nota de rodapé."
 ) 

#OBS.: Para salvar vá em Export > save as image 
#                        * Ajuste o tamanho para caber todas as informações,
#                        * Selecione o formato do arquivo se png ou jpeg,
#                        * Defina o diretorio, se não o fez
#                        * Nomei o arquivo
#                        * Clique em save
#=========================================================================

# v Crie um objeto e passe os dados para o formato wider usando a função pivot_wider()
df_wider <- df |> pivot_wider(names_from = estagio, 
                               values_from = riqueza, 
                               values_fill = 0)
df_wider
# vi Abrevie os nomes das colunas do objeto criado em v, usando a função rename()
df4 <- df_wider |> rename(E_4 = Climax,
                           E_3 = Medio_tardio,
                           E_2 = Medio_inicial,
                           E_1 = Inicial)
df4
# vii Ordene os níveis da variável estágio de modo que faça sentido ecológico.
attach(df)
levels(estagio)
estagios <- fct_relevel(estagio, c("Inicial", "Medio_inicial",
                                   "Medio_tardio", "Climax"))
levels(estagios)
par(mfrow = c(1, 2)) # Cria uma janela com UMA linha e DUAS colunas
plot(estagio, riqueza)
plot(estagios, riqueza)

par(mfrow = c(1, 1)) # Volta ao "normal".

# 5
# a. Obrter Média e EP
a <- df |> group_by(estagio) |> 
 get_summary_stats(type = "mean_se")
a
a <- df |> group_by(estagio) |> 
 get_summary_stats(riqueza,type = "mean_se")
a

# base
fig <- ggplot(a, aes(x = estagio, y = mean)) + 
 geom_pointrange(aes(ymin = mean-se, 
                     ymax = mean+se)
                 )
# Títulos do eixo
fig2 <- fig + labs(x = "Estágios Sucessionais", 
                  y = "Média da riqueza observada")
fig2
# Mudando o fundo
fig2 + theme_classic()

# Mudando os nomes do eixo x
fig2 + theme_classic() + 
 scale_x_discrete(labels = abbreviate)

# Use a função scale_x_discrete() para renomear os níveis 
# da variável explicativa
fig2 + theme_classic() + 
 scale_x_discrete(labels = c("A", "B", "C", "D"))

fig2 + theme_classic() + 
 scale_x_discrete(labels = c("1", "2", "3", "4"))

# outro jeito
fig2 + theme_classic() + 
 scale_x_discrete(limits = c("Inicial", "Medio_inicial",
                             "Medio_tardio", "Climax"),
                  labels = abbreviate)+
 ylim(0,25)

# 6
# Usando o GGpubr
ggerrorplot(df, 
            x = "estagio",
            y = "riqueza")

# mudando os eixos e cor
ggerrorplot(df, 
x = "estagio",
y = "riqueza",
xlab = "Estágios Sucessionais",
ylab = "Média da riqueza observada",
color = "estagio"
)
# média e erro padrão
ggboxplot(df, 
            x = "estagio",
            y = "riqueza",
            xlab = "Estágios Sucessionais",
            ylab = "Riqueza Observada",
            fill = "estagio",
          add = "mean_se"
)
# Retrirando a legenda
fig_final <- ggerrorplot(df, 
            x = "estagio",
            y = "riqueza",
            xlab = "Estágios Sucessionais",
            ylab = "Riqueza Observada"
) + 
 theme(legend.position='none') +
 scale_x_discrete(limits = c("Inicial", "Medio_inicial",
                             "Medio_tardio", "Climax"),
                  labels = abbreviate)


# 6 correto que a binca me puxou a orlha
ggscatter(df, x = "temp", "riqueza"
          )

ggscatter(df, x = "temp", "riqueza",
          xlab = "Temperatura em °C",
          ylab = "Riqueza de espécies"
)

ggscatter(df, x = "temp", "riqueza",
          xlab = "Temperatura em °C",
          ylab = "Riqueza de espécies",
          color = "estagio"
)
# olhar as linhas de regressão
ggscatter(df, x = "temp", "riqueza",
          xlab = "Temperatura em °C",
          ylab = "Riqueza de espécies",
          add = "reg.line"
)

dispersao<-ggscatter(df, x = "temp", "riqueza",
          xlab = "Temperatura em °C",
          ylab = "Riqueza de espécies",
          color = "estagio",
          add = "reg.line"
)

# 7
ggsave("erro.tiff", plot = fig_final,
unit = "cm", dpi = 300, height = 15, width = 20)  
ggsave("dispercao.tiff", plot = dispersao,
       unit = "cm", dpi = 300, height = 15, width = 20)  
