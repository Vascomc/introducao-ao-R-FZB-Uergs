##################################################################
# PPGSCBio: Mestrado em Sistemática e Conservação da Diversidade Biológica Uergs/SEMA-RS
# Introdução ao R
# Prof. Dr. Márlon de Castro Vasconcelos
# Aula 1: 16/02/2021
##################################################################
# Visão Geral sobre o R Studio
#   a. Diretório de Trabalho
#  1. Janelas
#   a. Scrit
#   b. console
#   c. enviroment...
#   d. files...
#  2. Global Options
#  3. Falando sobre Encoding
#  4. demo()
#  5. Lista de atalhos: CONTRL + SHIFT + k
#  6. Funções e sua estrutura
#   a. exemplo seq()
#  7. Tipos de dados
#   a. Númericos
#   b. Fatores
#   c. Characters
#  8. Operações matemáticas
#   a. Fundamentais
#   b. Raíz
#   c. Log
#  9. Objetos
# 10. Vetores e operação com vetores
# 11. Matrízes e operação com matrizes
# 12. Data frames
# 13. Manipulando elementos
#  a. Indicadores lógicos
# 14. Importando dados
#  a. XLSX
#  b. CSV
#  c. TXT
# 15. Atividades
##################################################################
# 2. Global Options

# 3. Falando sobre Encoding: Problemas com caracteres especiais.
#    File > Reopen with Encoding

# 4 demo()
demo()
demo(graphics)
demo(image)

# 5. Lista de atalhos
#  a. CONTROL + SHIFT + K: Windows
#  b. SHIFT + OPTION + K: Mac

# 6. Funções e sua estrutura básica
#  Ex.: função seq()

# O que ela faz?
??seq()

# obs.: Se uma função que não seja da "base" e sim de um pacote "externo", para obter ajuda dessa função é necessário que o pacote esteja carregado.

# Argumentos
#  * Meio pelo qual dizemos a função o que queremos que ela faça
#  * Meio pela qual a função funciona
#  * Argumentos SEMPRE SÃO SEPARADOS POR VIRGULAS.
#  * Os PONTOS são separadores decimais

seq(from = 1, # fghjk 
    to = 10)
seq(1,10)
seq(1.10)

seq(1:10)
# Mesmo que seq(1,4), isto é, produz o mesmo resultado

seq(1,10, by = 2)
seq(1,10, by = 4)
seq(1, 9, by = pi)

# Combinando funções
sum(seq(1,10))
sum(seq(1,10, by = 4))

#  7. Tipos de dados
#   a. Númericos: integer; double
#   b. Fatores: factor
#   c. Characters: character (string = letras)
#   d. Outros:
#     i. date
#     ii. geo
#     iii. etc


#  8. Operações matemáticas
#   a. Fundamentais
#      +; -; *; /; ^ 
5 + 3
5 - 1
5 * 4
32 / 2
5 ^ 2
5 ^ 3
5^2
#   b. Raíz
#      quadrada
sqrt(81)
#      demais raízes
81^(1/2)
81^(1/3)
81^(1/4)
81^(1/5)
#   c. Log
log(9) # Log Natural
log(9, base = 2.72)
log(9, base = 3)
log(9, 3) 
log10(9) # Log de base 10
log2(9) # Log de base 2
log1p(9) # log de (x + 1), mais usado para dados de comunidade por exemplo. Pois temos valores de ZERO na planilha, e log de ZERO não existe. Daí ao adicionar 1 e extrair o log, temos como resultado ZERO.


??base::matrix

S1<- seq(1,15)
S1
M1<-  matrix(nrow = 3, ncol = 5, S1,
             byrow = T)


a <- matrix(nrow = 5, ncol = 3, 
            c(0,1,5,7,2,6,4,5,2,14,5,6,10,0,0),
            dimnames = list(c("L1", "L2", "L3", "L4", "L5"),
                            c("Sp1", "Sp2", "Sp3")
                            )
            )
a

log(a)
log1p(a)

exp(2) # Mesmo que eˆx; onde x é o número que se quer.
2.71828^2 #
exp(3)
2.71828^3

# Expressões

2+4^3
(2+4)^3
# onde está a diferença???
4^3 + 2

# O resultado depende de como é a convenção da prioridade das resoluções das operações fundamentais.

# Objetos
# São uma forma de salvarmos informação. Ela pode ser listas, Matrízes, Valores, Vetores, Resultados estatisticos, etc.

a <- 2
a
a = 2
a
# O uso da FLECHA quando do IGUAL geram o mesmo resultado. Contudo, sugiro que usem a FLECHA, pois o IGUAL usamos em arumentação lógica e ai pode gerar confusão.

# 10. Vetores
#     Conjunto de valores de mesma natureza, onde cada valor é uma observação qualquer.
b <- c(1,2,3,4,5,6,7,8,9,10)
b
b <- seq(1,10)
b
b <- c(1:10)
b

# Operação com Vetores
b + 1
b - 1
b * 5
b / 2
b ^ 2
sqrt(b)
b ^(1/3)
log(b)
log10(b)
exp(b)

#  expressão com vetores
sum(b)/length(b)
sum((b - mean(b))^2) / (length(b)-1)
var(b)
# 11. Matriz
#     Conjunto de valores de mesma natureza ordenados ixj ou mxn onde:
#      i/m = linhas 
#      j/n = colunas 

matrix(c(1,2,3, 11,12,13), 
       nrow = 2, 
       ncol = 3, 
       byrow = TRUE,
       dimnames = list(c("row1", "row2"),
                       c("C.1", "C.2", "C.3")
                       )
       )
amor<-matrix(seq(1,6), 
       nrow = 2, 
       ncol = 3, 
       byrow = TRUE,
       dimnames = list(c("row1", "row2"),
                       c("C.1", "C.2", "C.3")
       )
)
Amor
c <- matrix(rnorm(6, mean = 20, sd = 5), 
       nrow = 2, 
       ncol = 3, 
       byrow = TRUE,
       dimnames = list(c("row1", "row2"),
                       c("C.1", "C.2", "C.3")
       )
)

c

c + 1
c - 1
c * 5
c / 2
c ^ 2
sqrt(c)
c ^(1/3)
log(c)
log10(c)
exp(c)

# obs.: Apenas operações simples, nada de "Algebra Linear".

# Nomeando as linhas de uma Matriz
#   - Sem usar o argumento 'dimnames'

matriz <- matrix(rnorm(50, mean = 20, sd = 5),
                 nrow = 10, ncol = 5, byrow = F)
matriz


rownames(matriz) <- rownames(matriz, 
                             do.NULL=FALSE, 
                             prefix = "Amostra.")
matriz

# Nomeando as colunas de uma Matriz

colnames(matriz) <- colnames(matriz,
                             do.NULL = F, 
                             prefix = "Sp")
matriz

# Somas de linhas e Colunas

colSums(matriz)
rowSums(matriz)

apply(matriz, 2, mean)
apply(matriz, 2, sd)
sd(matriz[,3])
apply(matriz, 1, mean)

# Supomos que temos 2 ambientes preservado e impactado na nossa matriz

fatores <- gl(2,5, labels = c("Preservado", "Impactado"))

rowsum(matriz, fatores)

tapply(matriz, list(fatores[row(matriz)], col(matriz)), sum)
tapply(matriz, list(fatores[row(matriz)], col(matriz)), mean)

aggregate(matriz,list(fatores),sum)
aggregate(matriz,list(fatores),mean)


# Adicionando linhas e colunas à uma matriz

matriz <- rbind(matriz,apply(matriz,2,mean)) # Média das Colunas
matriz
matriz <- cbind(matriz,apply(matriz,1,var)) # Variância das linhas
matriz 

colnames(matriz) <- c(1:5,"Variância")
matriz
rownames(matriz) <- c(1:10,"Média")
matriz



# 12. Data Frames
#     São conjuntos de dados com dados de diferentes tipos.
#     É o que "normalmente temos".

head(iris)
??iris # Explica o que é o conjunto de dados

# 13.  Podemos usar [] e operadores lógicos para retirar informações específicas do conjundo de dados; Matrizes e Vetores.

# Vetores:
# Vamos criar um vetor de números aleatórios
vetor <- rnorm(15, mean = 20, sd = 5)
vetor

vetor[5] # Quero o quinto valor
vetor[c(6,10)] # Quero o sexto e décimo valor

# Matrízes

matriz[3,5]
# O que foi diferente do vetor?

matriz[c(3,4), 5]

matriz[,5]
matriz[3,]

# Substituindo valores em um vetor e em matriz
vetor

vetor[5] <- 6.3
vetor

matriz[2,1]
matriz[2,1] <- 20
matriz[2,1]
matriz[3,] <- c(20,15,14,20,12)
matriz

# Data Frames
head(iris)
summary(iris)
names(iris)

# Pegando valores de uma única variável
iris$Sepal.Length

# Níveis de um fator
levels(iris$Species)

# Manipulando Data Frames com Operadores lógicos
iris$Sepal.Length[iris$Sepal.Length > 5] # Valores maiores que 5

iris$Sepal.Length[iris$Sepal.Length < 5]

iris$Sepal.Length[iris$Sepal.Length == 5]

iris$Sepal.Length[iris$Sepal.Length <= 5]

iris$Sepal.Length[iris$Sepal.Length < 5 | iris$Sepal.Length > 5 ] # | significa 'ou'

# Pegando valores de uma variável, condicionada a outra
iris$Sepal.Length[iris$Species == "setosa"]

iris$Sepal.Length[iris$Petal.Length >= 3]

# Uso do attach e detach
attach(iris) # Faz com que as variáveis do Data Frame virem objetos
names(iris)

Sepal.Length > 5

Sepal.Length[Sepal.Length > 5]

Sepal.Length[Sepal.Length > 5]

detach(iris) # Desfaz o attach


# 14. Importando dados

#####################################################################
#####################################################################
############# OBS.: SUPER MAGA HIPER IMPORTANTE #####################
# Nomes de compostos de pastas sem espaço
# Nomes de arquivos sem espaço
# Ex.: Pasta > Mestrado_dados
#      arquivo > dados_físicos.xlsx
#                comunidade_1.xlsx
#                comunidade_1.csv
#                comunidade_1.txt
#####################################################################
#####################################################################

# XLSX: Precisa do Pacote 'readxl'
readxl::read_xlsx("caminho do arquivo")

readxl::read_xlsx("/Volumes/MARLON-HD/DADOS_GERAL/ambiente_DOC.xlsx")


# CSV e TXT. Os arquivos precisam estar num diretório de trabalho.
read.csv(file = 'data/car-speeds.csv', 
         header = T,
         sep = ";" # depende do separador do arquivo
         )

read.table(file = 'data/car-speeds.txt', 
           header = T,
           sep = ";" # depende do separador do arquivo
)

# Usando o File > Import Dataset

######################### This is the End ###########################