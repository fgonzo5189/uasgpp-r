#Frank J. Gonzalez
#School of Government and Public Policy
#University of Arizona
#fgonzo@email.arizona.edu
#POL596A
#Fall 2018

####Vectors as Variables; Matrices as Data Sets####

#The variables (i.e., the columns) in a dataset (i.e., the matrix) can be thought of as "vectors" in the world of R. If you are a "visual learner," think 
#of a vector as a line on a graph made up of various single data points (scalars). In the context of a data set, the vector is comprised of each 
#data point in each row of a single variable. If the data set's rows consist of individuals, each data point represents an individual's 
#"score" on that variable. If the rows are countries, each data point is a country's score on that variable. 

#SO, doing statistical analysis is all about analyzing vectors that exist within matrices (i.e., data sets)!

#We often want to create our own vectors and matrices in order to build or manipulate functions, test things, etc. For this reason, R makes 
#it fairly easy to create and manipulate vectors and matrices and also to perform matrix algebra on them. 


####***Creating a vector#####

#'c' combines "component" elements into a vector

v1 <- c(3, 4, 5)
v2 <- c("sandwich", "cup", "plate") #Can be numbers or words

#Example from Monogan book: 

Y<-c(.808,.817,.568,.571,.421,.673,.724,.590,.251) #Republican share of the 2-party vote in 2010
X2<-c(.29,.34,.37,.34,.56,.37,.34,.43,.77) #Obama's share of 2-party vote in 2008
X3<-c(4.984,5.073,12.620,-6.443,-5.758,15.603,14.148,0.502,
      -9.048) #Degree of Republican financial advantage

#Always a good idea to check to make sure vectors are SAME LENGTH (if putting them into a single data set); if you have missing values, 
#make sure to put 'NA's where those should be.

length(Y)
length(X2)
length(X3) 

#Say we want a vector with a repeating pattern... use "rep"
?rep 
X1 <- rep(1,9) #what to put in each cell, how many times to repeat it. This is just the number 1 repeated 9 times in a single vector

#Sequential vectors
index <- c(1:9) #This is the numbers 1 through 9 in a single vector (colon prompts R to list sequential integers)
#Or: 
?seq
e <- seq(-2, 1, by=0.25) #The numbers from -2 to 1 in increments of .25.

#Just type the name of the vector and run it to see what's inside
e
X1

####***Creating a matrix#####

#There are several options for creating a matrix. 

#'Matrix' command
?matrix
b <- matrix(3, ncol=4, nrow=4, byrow=FALSE)
#Creates a matrix of '3's with 4 columns and 4 rows. 
#We can also fill the matrix with a vector of scalars (data points) - SO LONG AS it matches the number of rows and columns we define)
b2 <- matrix(c("first", "second", "third", "fourth", 
               "fifth", "sixth", "seventh", "eigth", 
               "ninth", "tenth", "eleventh", "twelfth", 
               "thirteenth", "fourteenth", "fifteenth", "sixteenth"), ncol=4, nrow=4, byrow=T)
b2
#The 'byrow' option, if set to TRUE, would fill the matrix row-by-row instead of column-by-column

#Combine vectors
X <- cbind(1, X2, X3)
X #cbind is a command that "combines" columns; if you put just a single number/scalar, it will repeat that number/scalar for each row
?cbind 
?rbind #rbind can be used if you want to combine rows instead
T <- rbind(1, X2, X3)
T

#Finally, you can also create a "blank" matrix and then subscript in values later. 
blank <- matrix(NA, ncol=3, nrow=3) #this is a 3x3 matrix of all missing values (NAs)
blank[1,3] <- 8 #Here we are filling the number '8' into the first row, third column of the blank matrix
blank[2,1] <- pi #Assign value of pi to 2nd row, 1st column
blank[,2] <- v1 #'v1' (object we created previously) is now the entire 2nd row
blank

#Creating easy-to-work-eith "test" data sets is also easy using the 'rnorm' command, which draws a random number from a normal 
#distribution a specified number of times
N <- matrix(rnorm(100, mean=10, sd=2), nrow=10, ncol=10) #We define the mean and sd as well as dimensions of the matrix
N

#Sometimes we only want a matrix with its diagonal elements (e.g., a correlation matrix or variance matrix)
D <- diag(c(1:4))
D

####***Converting to and from a data frame####

#Some commands will only work on matrices, and others will only work on data frames (which are a separate 'class' of objects in R). So, 
#you may often need to convert back and forth. Generally, "as.X" is how you convert an object from one class to another (e.g., 
#"as.factor", "as.data.frame", "as.numeric")

X.df <- as.data.frame(X)
X.df
tennessee <- as.data.frame(cbind(index,Y,X1,X2,X3))

X.m <- as.matrix(X.df)


####Arrays#####

#Arrays are just lists of multiple vectors. They can also be thought of as vectors with one or more dimensions (so a vector with one dimension
#is also an array). You may sometimes need to deal with arrays, but IMHO, you will usually just want to deal with matrices, which can usually
#serve the same purpose. 


####Vector/Matrix Commands####

length(X1) #length of a vector
dim(X) #rows and columns (dimensions) of a matrix
sum(X2) #sum of a vector's elements
mean(X2) #mean of a vector's elements
var(X2) #variance of a vector's elements

?apply #apply let's us apply a function to an array or a matrix (sort of like aggregate but without the grouping)
apply(X, 2, mean) #mean for each column of our X matrix (if the second argument is 1, it means take the mean of the columns for each row; 
#if the second argument is 2, it means take the mean of the rows for each column)

apply(X.df, 2, mean)















