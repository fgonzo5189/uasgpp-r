#Frank J. Gonzalez
#School of Government and Public Policy
#University of Arizona
#fgonzo@email.arizona.edu
#POL596A
#Fall 2018

#One of the coolest things about R is the ability to create your own functions. A function is essentially just making your
#own command that automatically "does stuff" to objects. The definition I've provided here is vague because of how incredibly vast the potential of what a function can do is. Here are some possibilities:

#You can make a function that does a particular statistical analysis that currently available commands and packages cannot 
  #do 
#you can make a function that does a particular statistical analysis that IS currently available in other commands/packages
  #but you simpy don't feel like looking up how to use the pre-existing commands
#you can make a function that restructures or transforms your data in a unique way
#you can make a function that automatically creates plots or tables based on analyses and then exports the images of those 
  #plots/tables
#you can make a function that does some trivial task but allows you to save time by doing it automatically on tons of data
#you can make a function within a function...within a function...etc. (aka an "Inception function" or "Turducken function"
# - just kidding they aren't called that at all)

#Believe it or not, you will often encounter scenarios where creating your own function is actually easier than finding a 
#package/command that already does what you want. 

#####FUNCTIONS#####

#You can create functions with the "function" command. This is the basic syntax for using the function command: 
#
#function.name <- function(INPUTS){BODY}
#
#"function.name" is the name of your function - it can be named whatever you want within the same rules as naming
#objects. Also, try not to name it after a command that already exists or it will create problems.

#"INPUTS" refers to the arguments you want your function/command to have. To make sure we are clear on this, 
#Let's quickly look at the "aov" command. 
library(stats)
?aov
#By looking at the help page for "aov", we can see that the arguments for this command are "formula" (where we 
#specify the model), "data" (where we tell it which data frame to use), and then some other optional arguments also
#described on the help page. We need to do the same for our function so that when we go to use the function, we can tell
#R what arguments to take into account when it runs that function. Obviously, the arguments you give to your function
#will vary tremendously depending on what the function is doing. 

#"BODY" is where you actually tell R what to do with the "stuff"/data you've entered into the function (via the 
#arguments/INPUTS). 

#Let's start with a "simple" example. Let's say we want to take the log of the sine of a number
my.first.function.yay <- function(x) {
  y <- log(sin(x))
  return(y)
}
#First of all, to create a function you have to highlight the entire function and run it (you cannot just hit
#Ctrl+Enter anywhere within like with some other commands). 
#Here, "x" is what I've named the first (and only) argument in my function. Then in the "BODY" of the function, 
#I give it the equation, where "something" called y will be the log of the sine of x (which will have been provided as 
#an argument in the function's command). 
#Then, IMPORTANTLY, I tell it what to actually "give me" after doing this 
#calculation. Here, I just want the value of "y", so I say "return(y)". 

#Note that the function should now appear in the "global environment" under "Functions."

#Let's give it a try:

my.first.function.yay(27)

#The "return" command is nice because we can specify what object from the function we want to return. For example: 

my.second.function.yay <- function(x) {
  y <- log(sin(x))
  return(x/2)
}
#If for some odd reason we wanted to return half of x (thus in this case pretty much totally negating the equation
#we are using), we can do that. 

my.second.function.yay(27) 

#Obviously, if I try to input a text string into the function, I get an error. 

my.second.function.yay("Hi") 

#If my function was made to handle text input, though, I'd be fine. 

my.third.function.yay <- function(x, y, z) {
  sentence <- c(x, y, z)
  return(sentence)
}

my.third.function.yay("orange", "pumpkin", 2) #note that here, "orange" is my first argument (x), "pumpkin" is my 
#second argument (y), and 2 is my third argument (z), all as defined in my function above.

#I can also use the "invisible" command instead of return if I want the function to create a value for y but not
#print it when the function is run

my.second.function.yay <- function(x) {
  y <- log(sin(x))
  invisible(x/2)
}

my.second.function.yay(27) #See? Nothing. But if I apply some other command to the result of running this function, 
#then you can see that the function did indeed work but simply didn't print out the result
summary(my.second.function.yay(27))
#This will be useful when you are using functions as means to other ends.


#Let's try it with some data, so I am manipulating a vector of values rather than a single number.

#Here's our old "tennessee" data:
Y<-c(.808,.817,.568,.571,.421,.673,.724,.590,.251) #Republican share of the 2-party vote in 2010
X2<-c(.29,.34,.37,.34,.56,.37,.34,.43,.77) #Obama's share of 2-party vote in 2008
X3<-c(4.984,5.073,12.620,-6.443,-5.758,15.603,14.148,0.502,
      -9.048) #Degree of Republican financial advantage
X1 <- rep(1,9)
index <- c(1:9)
x <- cbind(index,Y,X1,X2,X3)
X <- as.data.frame(x)

#If we just run the function on a vector, it will apply the function to each element one-by-one
my.first.function.yay(X$X2)
#So let's incorporate it into a plot!
plot(y=my.first.function.yay(X$X2), x=X$X2)

#BTW, if you want to use a command within a function that comes from another package, make sure to install and load the package beforehand and then
#type the name of the package, followed by "::" before typing the command within the function (e.g., "car::recode(...)")


#####LOOPS#####

#Loops are incredibly common in creating your own functions, as they allow one to repeat calculations over and 
#over across the elements of some vector, list, matrix, or data frame. 

#The most common way to create a loop is with the "for" command (called a "for loop"). Here is the basic syntax: 

for (i in 1:M) {COMMANDS}

#M is the number of times we want the command to be executed, so we can either define M somewhere else or input it 
#directly. We usually use "1:" to denote that we are talking about the first instance to the Mth instance, but if 
#you wanted to, for some reason, you could say "8:M" to only repeat the command from the 8th instance to the Mth. 
#"i" is what we usually use to denote the ith element in the vector/list/matrix/data frame/etc. (it stands for 
#"index"). This essentially means
#"for every 'i' in 1:M, do this". "COMMANDS" is where we tell it what to do to each i in 1:M. 

#Let's start with Monogan's example, where we demonstrate the "law of large numbers," which says that as you randomly
#choose values from population with a normal distribution with a mean of X and a standard deviation of Z, 
#the mean of your sample will
#come closer and closer to X with standard deviation Z as your sample increases (see other sources for a better 
#explanation). 

#To demonstrate the "law of large numbers," Monogan creates a blank matrix/vector of 1000 rows, and then uses a for loop
#to populate that matrix one-row-at-a-time with randomly selected values from a normal distribution with a mean of 
#0 and standard deviation of 1 (which is the default using the rnorm command in R). 
mat1 <- matrix(NA, 1000, 1) #blank matrix w/ 1000 rows and 1 column
for (i in 1:1000) {
  a <- rnorm(i)
  mat1[i] <- mean(a)
}
#This function creates an object called "a", which is a matrix that starts out as just 1 value and increases as 
#i increases (all the way to 1000, when it is a matrix with 1000 rows and 1 column (aka a vector of 1000 elements)). 
#Then the function assigns the mean of a for each iteration of the loop to the blank matrix, mat1. After 1000 
#iterations of the loop, mat1 should be fully populated with the mean for each value of i as the loop progressed. 
#Let's plot it to see it in action (we will use abline to draw a red line at 0)
plot(mat1, type="h", ylab="Sample Mean", xlab="Number of Observations/i")
abline(h=0, col="red", lwd=2)

#We can also use the "while" command to create loops. "while loops" differ from "for loops" because "for loops" do 
#something for a set range (e.g., do this 1000 times), whereas "while loops" do something until a 
#particular criterion is met (e.g., do this until X is greater than Y). Often, which type of loop to use is up to 
#the user's discretion and best judgment. Here is the syntax for a "while loop": 

j <- 1
while(j < M) {
  COMMANDS
  j <- j+1
}
#Here, COMMANDS is where you tell it what to do, and it will do that as long as j is less than M. In order for 
#while loops to work, then, you need to define j first (or j needs to be defined elsewhere), and you need a line
#in the while loop that iteratively adds to j so that at some point, j<M will no longer be true

#Example: 
k <- 1
while (k < 6) {
  print(k)
  k = k+1
}




#####BRANCHING#####

#You may often want to only do something if some criterion is true, in which case the if/else commands will 
#come in handy (note: this is different than the "ifelse" command we've talked about but essentially works the 
#same way and can be used to transform variables just like "ifelse"). 

#Basic syntax: 
if (logical_expression) {
  expression_1
  ...
}

#logical_expression indicates a statement that can either be true or false (called a Boolean) and expression_1 
#indicates the commands to implement when the logical_expression is true. 

#Here's an example that uses a for loop to randomly draw a number from 1 to 50 1000 
#times, and then counts how many times the randomly drawn number was even (sort of like Monogan example). 

even.count <- 0
for (i in 1:1000) {
  a <- sample(1:50, 1, replace=T)
  if (a%%2==0) {
    even.count <- even.count+1
  }
}
even.count

#We can make this a function. 

fun1 <- function(iters, sample.size) {
  even.count <- 0
  for (i in 1:iters) {
    a <- sample(1:sample.size, 1, replace=T)
    if (a%%2==0) {
      even.count <- even.count+1
    }
  }
  return(even.count)
}
#So here, "iters" is how many times to draw a random number, and sample.size is how large the sample is we are drawing
#from.

fun1(100,400)

#You can add "else" to tell it what to do when the boolean is not true, or a set of "else if" statements to 
#tell it what to do under specific circumstances.

fun2 <- function(iters, sample.size.lower, sample.size.upper) {
  even.count.pos <- 0
  odd.count.pos <- 0
  even.count.neg <- 0
  odd.count.neg <- 0
  for (i in 1:iters) {
    a <- sample(sample.size.lower:sample.size.upper, 1, replace=T)
    if (a%%2==0 & a>=0) {
      even.count.pos <- even.count.pos+1
    } else if (a%%2==0 & a<0) {
      even.count.neg <- even.count.neg+1
    } else if (a%%2!=0 & a>=0) {
      odd.count.pos <- odd.count.pos+1
    } else {
      odd.count.neg <- odd.count.neg+1
    }
  }
  output <- list(even.count.pos, odd.count.pos, even.count.neg, odd.count.neg)
  return(output)
}

#Here, I've simply added objects for the count of odd-numbered values but also separated the even.count
#and odd.count categories into whether or not they are negative.

fun2(10000,-400,400)



#####DEBUGGING#####

#If you ever run into errors in your function and it is a complex function, use "debug" to go line-by-line and 
#find out where the error is. 
?debug

fun3 <- function(iters, sample.size.lower, sample.size.upper) {
  even.count.pos <- 0
  odd.count.pos <- 0
  even.count.neg <- 0
  odd.count.neg <- 0
  for (i in 1:iters) {
    a <- sample(sample.size:sample.size.upper, 1, replace=T)
    if (a%%2==0 & a>=0) {
      even.count.pos <- even.count.pos+1
    } else if (a%%2==0 & a<0) {
      even.count.neg <- even.count.neg+1
    } else if (a%%2!=0 & a>=0) {
      odd.count.pos <- odd.count.pos+1
    } else {
      odd.count.neg <- odd.count.neg+1
    }
  }
  output <- list(even.count.pos, odd.count.pos, even.count.neg, odd.count.neg)
  return(output)
}

fun3(10000,-400,400)
debug(fun3)
fun3(10000,-400,400)
undebug(fun3)






#####A NOTE#####
#NOTE: R is a vector-based software and so in general, vector-based commands/functions tend to work much more quickly
#and efficiently than loop-based commands. This won't matter much unless you are handling large data sets or doing 
#lots of calculations (which is actually somewhat often), but if you have the option to use a vector-based command that
#uses matrix algebra to perform calculations on a series of elements one-by-one (e.g., "apply"), you should use that 
#instead of building a loop that does the same thing but by looping through individual row-by-row calculations rather 
#than just using matrix algebra on the vector. 





















