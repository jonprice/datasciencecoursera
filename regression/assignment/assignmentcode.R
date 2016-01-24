data("mtcars")





m0 <- lm(mpg ~ . , data = mtcars)
m1 <- lm(mpg ~ wt , data = mtcars)
m2 <- lm(mpg ~ wt + am , data = mtcars)
m3 <- lm(mpg ~ wt + qsec + am , data = mtcars)

fit <- lm(mpg ~ ., data = mtcars)
fit1 <- lm(mpg ~ wt, data = mtcars)
fit2 <- lm(mpg ~ wt + qsec, data = mtcars)
fit3 <-lm(mpg ~ wt + qsec + am, data = mtcars)
fit4 <- lm(mpg ~ ., data = mtcars)
anova(fit1, fit2,fit3, fit4)


m0 <- lm(mpg ~ wt + cyl , data = mtcars)
summary(lm(m0))
sqrt(vif(m0))

summary(lm(mpg ~ am , data = mtcars))



mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$am <- as.factor(mtcars$am)
levels(mtcars$am) <- c("auto", "man")

mtcars$gear <- as.factor(mtcars$gear)
mtcars$carb <- as.factor(mtcars$carb)


sort(cor(mtcars)[1,])
sort(cor(mtcars)[2,])
