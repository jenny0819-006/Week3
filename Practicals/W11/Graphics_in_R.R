# Part 1: Plot all base R symbols without using expand.grid().
symbol_x <- c(rep(1:6, 4), 1, 2)
symbol_y <- c(rep(5, 6), rep(4, 6), rep(3, 6), rep(2, 6), 1, 1)

plot(symbol_x, symbol_y,
     pch=0:25, cex=1.6,
     xlim=c(0.5, 6.5), ylim=c(0.1, 5.5),
     xaxt="n", yaxt="n", xlab="", ylab="",
     main="Base R plotting symbols (pch = 0:25)")
text(symbol_x, symbol_y-0.32, labels=0:25, cex=0.9)

# Part 2: Recreate the iris scatterplot in Figure 3B.
data(iris)

colors <- rep(NA, nrow(iris))
symbols <- rep(NA, nrow(iris))

colors[iris$Species == "setosa"] <- "grey80"
colors[iris$Species == "versicolor"] <- "grey50"
colors[iris$Species == "virginica"] <- "black"

symbols[iris$Species == "setosa"] <- 21
symbols[iris$Species == "versicolor"] <- 24
symbols[iris$Species == "virginica"] <- 22

plot(iris$Petal.Length, iris$Petal.Width,
     xlab="Petal length (cm)", ylab="Petal width (cm)",
     pch=symbols, col="black", bg=colors, cex=1,
     xlim=c(0.8, 7.2), ylim=c(0, 2.7),
     main="Iris petal length and width")

reg.setosa <- lm(iris$Petal.Width[iris$Species == "setosa"] ~
                 iris$Petal.Length[iris$Species == "setosa"])
reg.versicolor <- lm(iris$Petal.Width[iris$Species == "versicolor"] ~
                     iris$Petal.Length[iris$Species == "versicolor"])
reg.virginica <- lm(iris$Petal.Width[iris$Species == "virginica"] ~
                    iris$Petal.Length[iris$Species == "virginica"])

abline(coef(reg.setosa), col="grey80")
abline(coef(reg.versicolor), col="grey50")
abline(coef(reg.virginica), col="black")

legend(x=1.1, y=2.55,
       c("I. setosa", "I. versicolor", "I. virginica"),
       pch=c(21, 24, 22), cex=0.9,
       col="black", pt.bg=c("grey80", "grey50", "black"))
