###################
# Mestrado em Sistemática e Conservação da Biodiversidade
# Disciplina Introdução ao ambiente R
# Atividade 2
###################

# 3
# Carregando vários pacotes num comando.
pacman::p_load('tidyverse', 'rstatix', 'ggpubr')

# 4
estagio <- gl(4, 20, labels = c("Climax", "Inicial","Medio_tardio", "Medio_inicial")) 
temp <- c(rnorm(20, 13, 2), rnorm(20, 30, 2), rnorm(20, 22, 2), rnorm(20, 25, 2))
riqueza <- c(rpois(20, 20), rpois(20, 10), rpois(20, 18), rpois(20, 12))
df <- data.frame(estagio, temp, riqueza)
head(df)

summary(df)
str(df)
glimpse(df)


df_inicial <- df |> filter(estagio == "Inicial")
head(df_inicial)

df2 <- df |> filter(estagio == "Inicial" | estagio == "Climax")
df2$estagio <- fct_drop(df2$estagio)
summary(df2)

df3 <- df |> select(riqueza, temp) |> filter(temp > 25)
summary(df3)

resumo <- df |> group_by(estagio) |>
 get_summary_stats(type = "common")
resumo

df_wider <- df |> pivot_wider(names_from = estagio, 
                               values_from = riqueza, 
                               values_fill = 0)
df_wider

df4 <- df_wider |> rename(E_4 = Climax,
                           E_3 = Medio_tardio,
                           E_2 = Medio_inicial,
                           E_1 = Inicial)
df4

attach(df)

levels(estagio)
estagios <- fct_relevel(estagio, c("Inicial", "Medio_inicial",
                                   "Medio_tardio", "Climax"))
levels(estagios)
par(mfrow = c(1, 2)) # Cria uma janela com UMA linha e DUAS colunas
plot(estagio, riqueza)
plot(estagios, riqueza)

par(mfrow = c(1, 1)) # Volta ao "normal".

# 1. Obrter Média e EP
a <- df |> group_by(estagio) |> 
 get_summary_stats(type = "mean_se")
a
a <- df |> group_by(estagio) |> 
 get_summary_stats(riqueza,type = "mean_se")
a

# base
fig <-ggplot(a, aes(x = estagio, y = mean)) + 
 geom_pointrange(aes(ymin = mean-se, 
                     ymax = mean+se)
                 )


# Títulos do eixo
fig <- fig + labs(x = "Estágios Sucessionais", 
                  y = "Riqueza Observada")
fig
# Mudando o fundo
fig + theme_classic()

# Mudando os nomes do eixo x
fig + theme_classic() + 
 scale_x_discrete(labels = abbreviate)

fig + theme_classic() + 
 scale_x_discrete(labels = c("A", "B", "C", "D"))


fig + theme_classic() + 
 scale_x_discrete(labels = c("1", "2", "3", "4"))

fig + theme_classic() + 
 scale_x_discrete(limits = c("Inicial", "Medio_inicial",
                             "Medio_tardio", "Climax"),
                  labels = abbreviate)+
 ylim(0,25)

# Usando o GGpubr
ggerrorplot(df, 
            x = "estagio",
            y = "riqueza")

# mudando os eixos e cor
ggerrorplot(df, 
x = "estagio",
y = "riqueza",
xlab = "Estágios Sucessionais",
ylab = "Riqueza Observada",
color = "estagio"
)

ggboxplot(df, 
            x = "estagio",
            y = "riqueza",
            xlab = "Estágios Sucessionais",
            ylab = "Riqueza Observada",
            fill = "estagio",
          add = "mean_se"
)
# Retrirando a legenda
ggerrorplot(df, 
            x = "estagio",
            y = "riqueza",
            xlab = "Estágios Sucessionais",
            ylab = "Riqueza Observada",
            color = "estagio"
) + 
 theme(legend.position='none') +
 scale_x_discrete(limits = c("Inicial", "Medio_inicial",
                             "Medio_tardio", "Climax"),
                  labels = abbreviate)
 

