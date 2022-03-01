#Frank J. Gonzalez
#School of Government and Public Policy
#University of Arizona
#fgonzo@email.arizona.edu
#POL596A
#Fall 2018

#Matrix algebra is essential to statistical analysis, but there are many people who do statistical analysis without being familiar with the matrix 
#algebra that is necessary or, sometimes, even the fact that matrix algebra is required. This is often because nowadays single-word commands can 
#be used to instantly conduct complex analyses and spit out results. This is possible in R, and is usually the way we conduct analyses. However, 
#it is essential to know what is going on "under the hood" in order to use the single-word commands appropriately. R is great for this because
#it is built for the construction and transformation of vectors and matrices as well as matrix algebra. 

#This also is why it is possible to develop your own functions and statistical analyses using R. 

#Finally, a bit of matrix algebra is usually used in simple variable transformations without most people even really acknowledging it.

####Recreating the vectors/matrices from last time####

#Let's create some vectors and a matrix to work with

Y<-c(.808,.817,.568,.571,.421,.673,.724,.590,.251) #Republican share of the 2-party vote in 2010
X2<-c(.29,.34,.37,.34,.56,.37,.34,.43,.77) #Obama's share of 2-party vote in 2008
X3<-c(4.984,5.073,12.620,-6.443,-5.758,15.603,14.148,0.502,
      -9.048) #Degree of Republican financial advantage
X1 <- rep(1,9)
index <- c(1:9)

dud <- c(2, 4, 2, 2, 1, 6, 4, 6, 5, 9)

x <- cbind(index,Y,X1,X2,X3)
X <- as.data.frame(x)

#********#
#For a brief intro/refresher on matrix algebra, see 'POL682 Preview/Matrix Algebra Primer' document available on D2L. 
#********#

####Matrix Addition/Subtraction####

#easy: just '+' or '-'

#To add or subtract two vectors, the vectors *MUST BE OF THE SAME LENGTH* - otherwise, you will get an error. 

m <- Y + X2
m

m2 <- Y + dud #note the error shown here. 'm2' will not be created. 

#You can also add or subtract variables in a data frame to create a new variable

X$sum.1 <- X$X2 + X$X3
X$sum.1

#If you add or subtract a scalar/single number, it will add or subtract that scalar to/from every scalar in the vector

m3 <- Y - 2
m3

X$m3 <- X$Y - 2
X$m3

####Matrix Multiplication####

#For multiplication, there are a number of ways you might be doing your calculation. 

#You may want to multiply each element of a vector by a single number/scalar (i.e., conduct scalar multiplication). To do this, just use the 
#typical mathematical operator for what you are trying to do:

X2.2 <- 2*X2
X2.2

X$X2.2 <- X$X2*2
X$X2.2

#Or, you may want to multiply a vector by another vector on an element-by-element basis (i.e., multiply the first element of vector 1 
#by the first element of vector 2). If this is the case, you are again conducting scalar multiplication but. You can do this using 
#exponentiation or to take the log of each element of a vector as well.

X2.3 <- X2^2
X2.3

X$X2.3 <- X$X2^2
X$X2.3

X2.4 <- log(X2)
X2.4

X$X2.4 <- log(X$X2)
X$X2.4

X2.X3 <- X2*X3
X2.X3

X$X2.X3 <- X$X2*X$X3
X$X2.X3

#Or, you may want to actually do matrix/scalar multiplication (see POL682 Preview/Matrix Algebra Primer). For this, R has built-in operators that are
#specific to matrix algebra. If multiplying vectors, you can calculate the scalar product (also called inner product or dot product): 

X2.X3b <- X2%*%X3
X2.X3b #Now, the result is the scalar product of the two vectors, which is a single number

zz <- X$X2%*%X$X3
zz #You can do this with variables in a data frame too, but remember the result is a single number 
#and so you cannot create a new column/variable from this equation. You can, however, just make an object from it.


#You can also calculate what is called the "tensor product" (or "outer product), which is useful for many statistical analyses. To do this, 
#you simply multiply one vector by the transpose of the other vector. To get the transpose of a vector, just use the 't' command.

X2.X3c <- X2%*%t(X3)
X2.X3c #This results in a matrix that has as many rows and columns as there are columns in the original matrices

#Remember that matrices must be conformable to be multiplied - otherwise R will return an error. 

b <- matrix(3, ncol=4, nrow=4, byrow=FALSE) #just making a quick 4x4 matrix

x%*%b #not the error

b2 <- matrix(3, ncol=5, nrow=9, byrow=FALSE) #this should work better

x%*%b #dang! Oh right, the number of columns from the first matrix needs to match the number of rows from the second...

b3 <- matrix(3, ncol=9, nrow=5, byrow=FALSE) #this should work better

x%*%b #aha!

#####Calculate the determinant####

#must be a square matrix. Then, use the "det" command!

det(b)

####Matrix Division####

#There is no such thing as matrix division! Just multiplying by the inverse...

####Multiplying a matrix by its inverse####

#Well, you can find the inverse and multiply by it. 

#Remember, a square matrix only has an inverse if its determinant is nonzero!

#The "solve" command gives you the inverse: 
solve(b) #Well, the determinant of b actually was 0, so this error is saying the matrix is exactly singular - i.e., has no inverse!

#Let's try another:

b4 <- matrix(NA, ncol=3, nrow=3) #this is a 3x3 matrix of all missing values (NAs)
b4[,1] <- c(5, 2, 1) 
b4[,2] <- c(8, 10, 2)
b4[,3] <- c(2, 4, 6)
b4
det(b4)

#Okay this one works now: 

Inv.b4 <- solve(b4)
Inv.b4%*%b4 #An identity matrix (note that rounding decisions by R show really really tiny values instead of 0s)



#Further, even though there is no such thing as matrix division, you can do element-by-element division (similar to what you do with scalar
#multiplication) by using the "regular" division sign

x2.x3b <- X2/X3
x2.x3b




####Using Matrix Algebra for Variable Transformations - the problem of missing data####

#It may seem like using these matrix algebra expressions to transform variables is straightforward. For example, if I want to create a variable
#that is Obama's vote share in 2008 plus 10 (for some reason), shouldn't I just be able to write "X$X2.10 <- X$X2 + 10"? Well, this is indeed
#how this works...SOMETIMES. 

#If you have missing data, your vectors are no longer of the same length, meaning they are no longer conformable for
#matrix addition or subtraction! For element-by-element equations, this is 'sometimes' a problem. 
#But don't panic, because 
#with the help of some R commands, we have tools for transforming variables even with missing data (although how to handle missing data
#from a theoretical standpoint is an entire discussion in itself). 

#Let's create the same data frame but with some missing data. 

v1 <- c(5, 2, 1, NA, 3, 3, 2, 1) 
v2 <- c(NA, 10, 2, 3, 2, 1, 9, 7)
v3 <- c(2, 4, 6, 4, 5, 1, 7, 8)
v4 <- c(10, 10, 8, 2, 1, 1, 4, 7)
b5 <- matrix(NA, ncol=4, nrow=8) 
b5[,1] <- v1
b5[,2] <- v2
b5[,3] <- v3
b5[,4] <- v4
b5

df <- as.data.frame(b5)

#Let's add and subtract some things
u <- v1+v3
u
u2 <- v1-v3
u2
u3 <- v1 + 10
u3
#As you can see here, for addition and subtraction, R knows how to handle missing values automatically; it reads 
#the NA in the vector as an element so that the matrices remain of the same length, and simply gives you an NA 
#for the result for the element where the NA was encountered.

df$u <- df$V1 + df$V3
df$u2 <- df$V1 - df$V1
df$u3 <- df$V1 + 10
#Same with data frames

u4 <- v1*v3
u4
u5 <- v1/v3
u5
u6 <- v1*10
u6
#Same with multiplication and division...

df$u4 <- df$V1*df$V3
df$u5 <- df$V1/df$V3
df$u6 <- df$V1*10

#Matrix multiplication - same thing

v4%*%v3
df$V4%*%df$V3

#BUT what is it doing with the missing values? Well, anytime an NA is encountered, it returns an NA for the 
#resulting scalar in the resulting matrix. This may or may not be what you want to happen. Sometimes, you
#do not want a value to be given for a variable if one of the variables comprising it is missing. Other times, 
#you still want a value to be given.


#This is especially relevant when trying to create a new variable that is the mean or sum of several other
#variables, which is something we do quite often!

df$u7 <- df$V1 + df$V2 + df$V3/3
df$u7

#Here, NAs are given where NAs are encountered. But what if you want values for the mean of non-missing
#columns? There are some instances in which virtually no rows that you are trying to sum or average over
#are completely free of NAs, and you want R to give you the mean of 6 items for some rows but the mean 
#of 7 items for other rows, depending on how many non-missing columns that row has (there is much
#debate in psychometric measurement about what the best practice is). 


#The solution is to use commands/functions that "handle" NAs for data frames. 
#'apply' is the most versatile: 

?apply 
dfx <- df[, c(1:3)]
dfx #as you can see, this requires that I create a subset of the data frame that only contains
#the columns I am interested in (or I can simply write "df[, c(1,3)]" instead of "dfx" below - does the same thing)
v5 <- apply(dfx, 1, sum, na.rm=T) 
v5 #Now, if there is a missing value, you can choose whether 'apply' returns "NA" (na.rm=F) or calculates the 
#function for all non-missing columns
#Remember, the "1" as the second argument means apply the function to each row of each column ("2" is the reverse)
df$v5 <- v5
df$v5 #you can then attach that new object to your data set

#For subtraction, unfortunately, there isn't really a separate function that will take into account NAs like this, 
#and so the (well "a") solution is to calculate the sum of the first column and -1 times the second column...
dfy <- df[, c(1,3)]
dfy[, 2] <- -1*dfy[, 2]
dfy[, 2]
df$v6 <- apply(dfy, 1, sum, na.rm=T) #you can also add the new column directly into your data set
df$v6
#We will go over another way of doing this by creating our own function within 'apply' later

#the mean:
df$v7 <- apply(dfx, 1, mean, na.rm=T) 
df$v7 

#people (myself included) often use the rowSums or rowMeans (or colSums or colMeans) commands to do the same
#thing - these commands are just a bit quicker when working with large data sets and are more efficient. 
?rowSums
df$v5 <- rowSums(dfx, na.rm=T)
df$v5
?rowMeans
df$v7 <- rowMeans(dfx, na.rm=T)
df$v7


#multiplication:
df$v8 <- apply(dfy, 1, prod, na.rm=T)
df$v8

#division is like subtraction, unfortunately, where the easiest way is to multiply by the inverse of each element 
#(shown below) or use our own function (will go over later)
dfz <- df[, c(1,3)]
dfz[, 2] <- 1/dfz[, 2]
dfz[, 2]
df$v9 <- apply(dfz, 1, prod, na.rm=T) 
df$v9



