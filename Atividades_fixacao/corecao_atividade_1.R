# 2
vetor<-rnorm(30,mean = 5, sd = 2)

# 3
vetor*3
vetor/2
log(vetor[15])
vetor_2 <-sample(vetor, size = 10)
(vetor*vetor_2)^(1/6)

# 4
matriz <- matrix(rpois(50, lambda = 5), 
            nrow = 10, 
            ncol = 5, 
            byrow = TRUE
            )
matriz_2 <- matriz*5
matriz_2[,2]<-seq(0,0,length.out = 10)
apply(matriz_2, 1, mean)
apply(matriz_2, 2, mean)
matriz_2<-cbind(matriz,apply(matriz,1,mean))
matriz_2<-rbind(matriz,apply(matriz,2,mean))
matriz_3 <- log1p(matriz_2)
matriz_4 <- sqrt(matriz_2)

fatores <- c("A", "A", "A", "A", "B", "B", "B", "C", "C","C")
fatores_2 <- factor(fatores, levels = c("A", "B", "C"))
fatores_2 <- as.factor(fatores)

aggregate(matriz_2, list(fatores), mean)

soma_1 <- rowSums(matriz)
soma_2 <- rowSums(matriz_2)

plot(soma_2, soma_1)

matriz_5<-matriz-mean(matriz)/sd(matriz)

#5

help(mtcars)

mtcars2 <- within(mtcars, {
  vs <- factor(vs, labels = c("V", "S"))
  am <- factor(am, labels = c("automatic", "manual"))
  cyl  <- ordered(cyl)
  gear <- ordered(gear)
  carb <- ordered(carb)
})

str(mtcars)
str(mtcars2)


plot(mtcars2$am, mtcars2$mpg)

mtcars2$mpg[mtcars2$am == "manual"]
mtcars2$mpg[mtcars2$am == "automatic"]
summary(mtcars$mpg)
mtcars2$mpg[mtcars2$mpg >= 22.8]

attach(mtcars2) # faz com que o R reconheça as variáveis como objetos
mpg[am == "manual"]
mpg[mpg >= 22.8]
