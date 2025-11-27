############################
# Mestrado Sistemática e Conservação da Biodiversidade
# Disciplina de Introdução ao ambiente R
# Atividades 1
############################

# 2 Crie e salve em um objeto um vetor com 30 elementos usando a função rnorm()
set.seed(123) # inciador dos números aleatórios
vetor <- rnorm(30, mean = 20, sd = 5)
rnorm(30)
# 3 . Nesse vetor faça as seguintes operações
# a) Multiplique por 3
vetor * 3
# b) divida por 2
vetor / 2
# c) extrair o log do 15 elemento
log(vetor[15])
# d) obtenha uma amostra com 10 elementos
vetor2 <- sample(vetor, size = 10)
# e) multiplique os dois objetos criados e extraia a raiz sexta e 
#      salve em um novo objeto
vetor3 <- (vetor*vetor2)^(1/6)

# 4 Crie uma matriz 10x5, Preencha essa matriz com valores usando a função 
#   rpois(lambda = 5) e salve em um objeto
set.seed(123)
matriz <- matrix (nrow = 10,
                  ncol = 5,
                  rpois(50, 5)
                  )
# a) Nomeie as colunas e linhas da matriz
rownames(matriz) <- rownames(matriz, do.NULL = F,
                             prefix = "Amostra")
colnames(matriz) <- colnames(matriz, do.NULL = F,
                             prefix = "sp")
# b) Multiplique por 5 a matriz e a salve em um objeto
matriz2 <- matriz*5
# c) Substitua a 2° coluna por valores iguais a Zero
matriz3<-matriz2[,2] <- seq(0,0,length = 10)
# d) Use a função apply() e cbind() para adicionar uma coluna e uma linha com médias à
#    matriz original e salve em um objeto
matriz4 <- cbind(matriz, apply(matriz, 1, mean))
matriz4
colnames(matriz4) <- c(1:5, "Média")
matriz4
matriz4 <- rbind(matriz4, apply(matriz, 2, mean))
rownames(matriz4) <- c(1:10, "Média")
matriz4
# e) Tendo o objeto criado em b, extraia a o logaritmo natural e extraia a 
#    raiz quadrada e salve em um objeto
matriz5 <- sqrt(log1p(matriz2))
matriz5
# f) Crie um objeto sendo um fator. Para isso, use a função c() tendo as letras A, B e C, 
#    como informação, sendo 4, 3 e 3x respectivamente. Após transforme isso em 
#    um fator com a função factor(levels = ).
fator <- c("A","A", "A", "A", "B", "B","B", "C", "C", "C")
fator <- factor(fator, levels = c("A", "B" , "C"))
fator
# g) Use o fator criado em f para obter médias e desvio padrão das colunas da matriz 
#    original usando a função aggregate().
aggregate(matriz, list(fator), mean)
aggregate(matriz, list(fator), sd)
# h) Some as linhas da matriz criada em b e a original. Use a função plot(original, b) 
#    e observe a relação entre os valores
soma1 <- rowSums(matriz)
soma2 <- rowSums(matriz2)
plot(soma1, soma2)
# i) Subtraia cada valor da matriz original pela média dos valores e divida pelo desvio padrão dos valores.
# Salve em um objeto. Compare as Média e o DP das três  primeiras colunas da matriz 
# original com essa nova. O que houve?
matriz6 <- (matriz-mean(matriz))/sd(matriz)
apply(matriz6, 2, mean)
apply(matriz6, 2, sd)
apply(matriz, 2, mean)
apply(matriz, 2, sd)

# 5
# a) Use a função help() para obter informações sobre esse conjunto de dados
help(mtcars)
# b) O conjunto de dados refere-se a informação de consumo de diferetens carros
#    baseado em uma série de características desses automoveis.
# c) Use o exemplo para criar o conjunto mtcars2. Use o # para criar comentários sobre o 
#    que cada linha do código está fazendo. Use a função str() para avaliar as variáveis 
#    em mtcars2 em comparação a mtcars
mtcars2 <- within(mtcars, {
  vs <- factor(vs, labels = c("V", "S")) # transforma a variável em um fator
  am <- factor(am, labels = c("automatic", "manual")) # transforma a variável em um fator
  cyl  <- ordered(cyl) # cria uma variável ordinalcom os níves de cyl
  gear <- ordered(gear) # cria uma variável ordinal
  carb <- ordered(carb) # cria uma variável ordinal
})
summary(mtcars2)

str(mtcars)
str(mtcars2)

# d)Sobre o mtcars2, use [] e operadores lógicos para:
# i. Valores de mpg quando am igual a manual
mtcars2$mpg[mtcars2$am=="manual"]
# ii. Valores de mpg quando hp for maior ou igual que o 3° quartil
summary(mtcars2$hp)
mtcars2$mpg[mtcars2$hp>= 180.0]

# e) Use a função split(), para separar o mtcars2 baseados na variável am
split(mtcars2, mtcars2$am)

# f) Repita d e e após usar a função attach().
attach(mtcars2)
mpg[am == "manual"]
mpg[hp>= 180.0]

split(mtcars2, am)

