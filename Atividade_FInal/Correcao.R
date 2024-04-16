############################################################
# Mestrado em Sistemática e Conservção da Biodiversidade
# Prof. Márlon de Castro Vasconcelos
# Correções atividades Final 2
############################################################

# 1.  Carregue os pacotes, **tidyverse**, **rstatix, kableExtra** e **ggpubr**;

pacman::p_load(tidyverse, rstatix, kableExtra, ggpubr)

# 2. Crie um objeto e transforme as variáveis *character* em *factor*;

dados <- read.table("https://raw.githubusercontent.com/Vascomc/introducao-ao-R-FZB-Uergs/main/Atividade_FInal/dados.txt",
                    h = T)

df <- read.table("dados.txt", h = T, sep = ",") # ao carregar o arquivo da pasta do diretório.

dados <- dados |> convert_as_factor(Ambiente)
glimpse(dados)


# 3. Crie uma tabela de resumo estátistico para o número de indivíduos para cada ambiente;

resumo <- dados |> group_by(Ambiente) |> get_summary_stats(abundancia, type = "common")

# 4. Crie um boxplot para a riqueza e abundância.

fig.riqueza <- ggboxplot(dados, x = "Ambiente", 
                         y = "riqueza", 
                         ylab = "Riqueza de espécies observada")
fig.abundancia <- ggboxplot(dados, x = "Ambiente", 
                            y = "abundancia", 
                            ylab = "N° de indivíduos observada")

# 5. Aplique operadores lógicos para selecionar:

     # 1.  Somente dados para o ambiente de Mata;
dados.mata <- dados |> filter(Ambiente == "Mata")

    # 2.  Para quando os valores de abundância forem maiores que 100;
dados.abund <- dados$abundancia[dados$abundancia > 100]

    # 3.  Valores de densidade menores que o 1° quartil e maiores que o 3° quartil da riqueza.
summary(dados$riqueza)
dados.dens <- dados$Densidade[dados$riqueza < 10.71 | dados$riqueza > 11.65]

# 6. Passe o conjunto para formato *wide* tendo como base a variável ambiente e salve em um objeto, 
#   e mostre as 6 primeira linhas desse objeto como uma tabela.

dados.wide <- dados |>
  pivot_wider(names_from = Ambiente, values_from = riqueza, values_fill = 0)
head(dados.wide)


# 7. Crie uma matriz, contendo 15 linhas e 5 colunas. Preencha as colunas usando distribuição Normal 
#    para as 3 primeiras colunas e distribuição de Poison para as duas ultimas.

matriz <- matrix(nrow = 15, ncol = 5, 
                 c(
                   rnorm(15, 5, 2),
                   rnorm(15, 10, 3),
                   rnorm(15, 7, 2),
                   rpois(15, 4),
                   rpois(15, 2)
                 )
                 )

# 8. Baixe o logo da FZB e o insira no arquivo, sendo centralizado e com 40% de seu tamanho original.

![logo FZB](/Users/marlonvasconcelos/DISCIPLINAS/Mestrado/Introdução_ao_R/fzb.png){width=40%}

# 9. Que comando usamos para que o R entenda as colunas de um conjunto de dados como se fossem objetos? 
#    exemplifique num chunck.

```{r, }
attach(dados)
```

# 10. Crie dois gráficos de dispersão e os agrupe ussando a função ggarange().

      # 1. Variável explicativa Matéria Orgânica e a resposta a Densidade;
      # 2. Mesmo em 1, porém com a forma dos pontos baseada nos diferentes ambientes. Qual sua conclusão?

```{r }

fig1 <- ggscatter(dados, x = "MO", y = "Densidade", 
                  ylab = "Densidade de orgânismos",
                  xlab = "Matéria Orgânica")
fig2 <- ggscatter(dados, x = "MO", y = "Densidade", 
                  ylab = "", xlab = "Matéria Orgânica",
                  color = "Ambiente", shape = "Ambiente")

ggarrange(fig1, fig2, labels = c("A", "B"))
```

# 11. Dados os dados abaixo:

ambiente <- data.frame(list(
  Locais = c(1:20),
  OD = rnorm(20, 6, 0.5),
  temp = rnorm(20, 23, 1),
  pH = rnorm(20, 7, 0.2),
  Cond = rnorm(20, 50, 30),
  estagio = gl(4, 5, 
               labels = c("Climax", "Inicial","Medio_tardio", "Medio_inicial")) 
))

comunidade <- data.frame(list(Locais = c(1:20),
                              Sp1 = rpois(20, 2),
                              Sp2 = rpois(20, 5),
                              Sp3 = rpois(20, 10),
                              Sp4 = rpois(20, 13),
                              Sp5 = rpois(20, 13),
                              Sp6 = rpois(20, 1),
                              Sp7 = rpois(20, 0.5),
                              Sp8 = rpois(20, 4)))

# 1. Como podemos juntar dos dois conjuntos de dados e exeportá-los como arquivo .csv ?

dados.juntos <- left_join(ambiente,comunidade,by="Locais")
write.csv(dados.juntos, "dados_juntos.csv")

# 12. Usando o pacote GGplot crie um gráfico de erro, usando como dados, a abundância de espécies por 
#     estágio do exercício 11

dados.juntos$abundancia <- rowSums(comunidade[,2:9])
dados.juntos$abundancia 

resumo <- dados.juntos |> group_by(estagio) |> get_summary_stats(abundancia, type = "mean_se")
resumo
j <- ggplot(df, aes(grp, fit, ymin = fit - se, ymax = fit + se))
j + geom_errorbar()
j + geom_pointrange()

j <- ggplot(resumo, aes(estagio, mean, ymin = mean - se, ymax = mean + se))
j + geom_errorbar()
j + geom_pointrange() +
ylab("Abundâncias médias observadas") +
xlab("Estágios sucessionais") +
scale_x_discrete(limits = c("Inicial", "Medio_inicial", "Medio_tardio","Climax"))





