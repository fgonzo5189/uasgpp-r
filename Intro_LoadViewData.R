#Frank J. Gonzalez
#School of Government and Public Policy
#University of Arizona
#fgonzo@email.arizona.edu
#POL596A
#Fall 2018

####Comments####

# = comments. Comments are ignored by R when running the script. Text not preceded by a "#" will be taken as 
#code to be run

#In R Studio, you can create section titles by enclosing text between 4 or more #s (see "Comments" above). On the bottom 
#left corner of your script window, you can click for a dropdown menu of all your section titles (makes it easier
#to navigate long scripts)

#To turn large blocks of text into comments, just highlight the lines of text and hit 'Ctrl+Shift+C' (use Cmd instead
#of Ctrl on Mac) - hit those keys again to "uncomment" those lines

# sdfsdfdsf
# sdfsdfsdf
# sdfsdfsdfsdf
# sdfksjhdfflksdj

#####Running Code#####

#The script window (what this text is in) is where you type out your code. The console window (below by default)
#is where the results of code that you run appear. You may also type code directly into the console if you wish and hit
#'Enter' to run it, but be warned the code you run directly through the console will not be saved in your script
#(it is usually useful when you want to just quickly run a command but don't need it saved in your script)

#To run a line of code from the script window, you can either: a) click anywhere on the line of code you want to 
#run and hit 'Ctrl+Enter' or 'Ctrl+R' (for Windows) or 'Cmd+Enter' (for Mac), b) highlight the section of code you want to run and
#hit the same keys, or c) highlight the code you want to run and click the 'Run' button on the top right. 

#Let's start simple. As all programming courses do, let's start by making the text "Hello, world." appear in the console. 

"Hello, world."

#Easy, right? 

# #Some important notes: 
# - Code is case-sensitive
# - There is no need to use any special delimiter to separate command lines; line breaks and indentation
#   are used purely for organization/aesthetics
# - Spaces between words in a command are ignored - the "problem" with your code is never that you accidentally
#   have an extra space somewhere (unless it's a space in the middle of a single word...)



#####R as a computing environment#####

#R is called a "computing environment" because it can serve a variety of functions. For instance, R can be a simple
#calculator by simply typing equations and running them. 

#####***R as calculator#####
#(note: I personally like to use *** to indicate subsections - but that is just my own personal preference)

2+2 #addition
2/2 #division
2-2 #subtraction
2*2 #multiplication
2^4 #exponentiation
sqrt(9) #square root
22%%4 #taking the modulus (the remainder after division)
22%/%4 #integer division (division to nearest whole number)

#Order of operations is determined by parentheses (well, PEMDAS)
2-6*8
(2-6)*8

#Note that if I put quotations around this, it would just show me the text. 

"(2-6)*8"

#You can control how many digits are shown in your outpute like this: 
options(digits=4) 

#There are some other helpful built-in mathematical commands too, including: 
sin(5) #sine
cos(5) #cosine
tan(5) #tangent
pi #pi



#But R is also used to create and manipulate objects and functions and, of course, to conduct statistical analyses.

#####***R as programming application#####

#"Objects" 

#Objects are an incredibly important part of using R. Basically, you "assign" things to be objects in order to 
#use them in other commands, expressions, etc. This will become more clear as we continue. Here are some examples:

#An object that contains the expression '5*2'
x.1 <- 5*2 #'<-' is used to assign whatever is on the right to the object, which is the text on the left. 
#objects can be named anything but cannot use special characters (e.g., -, $, &, _) except for periods. 
#Then simply 'run' the object to display what's inside to the console. 
x.1 #What appears in the console depends on what the object is. If it is a mathematical expression, the result
#will appear. 
x.2 <- "Hi again, world."
x.2 #If it's text, the text will be shown. 
x.3 <- matrix(1:24, nrow=4)
x.3 #If it's a matrix, it will print the matrix (more on how I created the matrix later)
#Of course, I can name the objects whatever I want. 
ThisIsAReallyCoolObject <- c("not", "a", "cool", "object") #btw, this one is a "vector" (discussed later)
ThisIsAReallyCoolObject

#To see the objects you've created: 
objects()
#or
ls()

#To remove objects: 
rm(list="ThisIsAReallyCoolObject") #note the object name is in quotations

#Also, not that in the top right window, you can see your "Environment," which lists your objects in categories
#(e.g., "data", "values", etc.). 



#####Getting Help#####

#You will often be using commands and functions. We have already used some (e.g., sqrt, sin, tan), but you will 
#also be using a wide range of commands from 'packages' (explained below). Fortunately, getting help with how to 
#use commands is easy in R, as any command within R (whether through a package or built-in) has a Help file
#that goes with it (unless it's a command you've created). Just type '?' before the command. 
?lm
#See? Now the bottom right window should show the help page for the command 'cos' (along with 'sin' and 'tan', etc. 
#in this particular case). 

#'??' will search the R archives (called CRAN) to see if the command shows up in existing packages
??cos

#If ? and ?? fail, Google it! If you speak to R users, you will quickly find that a good deal of knowledge
#comes from googling questions and reading responses on forums like StackOverflow to try out code and see 
#what works.



#####Working Directory#####

#You will often want to manipulate where you are saving files to and loading files from (this way you aren't always
#needing to type out entire file paths). It is pretty easy to set your working directory to whatever folder you are
#working out of. 

setwd("C:/Users/fgonzo5189/Dropbox/Teaching/Teaching 2018-2019/Fall 2018/POL596A/Scripts")
#Annoyingly, R needs you to use "/" instead of "\", which is the default for Windows...
#You can use 'setwd' to change the working directory at any point. 

#To see what the current working directory is: 
getwd()


#####Saving Output#####

#You can save output into a directory on your computer directly, or even create a new .csv or text file. This will
#be especially helpful when making figures/graphs or when trying to save results of analyses somewhere. 

#To put output into a new file in the working directory, use the 'sink' built-in function. Let's say we want 
#to create a text document called "Random stuff." 
sink("Random Stuff.txt") #a blank text document should now appear in your working directory
print("Bill: This sure is a boring text document.") #Now, a line will appear on the text document with this text.
print("Sarah: I don't know, it's kind of cool, no?") #Now a second line will appear below it.
print("Bill: Maybe if I do this!") #and another
print(c("3*4 = ", 3*4)) #You can create a vector with text and mathematical results
print("Sarah: No definitely less cool now.")
#If I just type in equations, they will appear in the document, too: 
3*9
#The 'cat' command lets you mix in objects with text: 
?cat
x.1 <- pi/2 #note that this x.1 object will now replace the x.1 object I had created before!
cat("Pi divided by two, times 8 equals: ", 8*x.1, "\n") #note that I can apply mathematical manipulations to the object
#within the cat command, as long as the object is numerical
#The "separator" "\n" is used so that each item in the 'cat' command list appears on a new line: 
cat("Pi divided by two, times 8 equals: ", 8*x.1, "Divided by 3 equals: ", (8*x.1)/3, sep = "\n")

#To turn off the sink command and thus stop adding to the document, type: 
sink()
#If you turn sink off and then on again, it will start a new document under that name.


#####PACKAGES#####

#Packages are, well, packages created by R users and accepted into the CRAN archive containing commands, functions, and sometimes data sets related
#to particular purposes. To use different packages, you must install them (only necessary one time for each computer you are using) and then 
#load them (each time you open an R session and want to use them). 

#Here are some examples of packages and what they do, so you get an idea: 

#"car": John Fox's base R package containing many basic functions and commands as well as data sets to use
#"foreign": for reading and writing data files from other software (e.g., csv, SPSS, SAS, Stata, text document)
#"ggplot2": for creating graphs and figures that are super pretty
#"lattice": also for creating graphs and figures that are super pretty
#"dplyr": useful functions for subsetting, manipulating, and rearranging data sets
#"rgl": for creating interactive 3D visualizations
#"psych": various functions and commands for psychometric analyses commonly used in psychology

#There are well over 10,000 packages available through CRAN. 

#Note: Packages often have dependencies - that is, other packages that they utilize - and so require downloading other packages. R will do this 
#automatically but occasionally there are errors because R cannot download some dependencies. When this happens, it usually means you need to 
#update your version of R (Help -> Check for Updates) or one of the packages it is utilizing is out-of-date (in which case I'd recommend not 
#using that package). 

#Let's install and load one. 

install.packages("car") #again, only need to do this first time
library(car) #need this every time you use it

#Sometimes, the same command is defined by two different packages and this causes problems, and so you may want to remove packages. 

remove.packages("car")




#####Loading Data Sets#####

#Loading data into R is very important for obvious reasons. Data sets are essentially rectangular matrices. Usually, the rows are the unit of analysis
#(e.g., individuals, countries, country-years, time points) and columns are different variables (i.e., the factors you are studying)

#There are various formats your data may be in that you have to deal with. 

#####***Text document#####

#read.table will read in a variety of types of data as long as they are delimited somehow (with a tab, space, semicolon, etc.)
#Let's look at the options for the command
?read.table #There are many, but usually we only need to use a few

#You always want to assign the data to an object with a short, easy-to-type name (you will be typing it a lot)

#Let's start with the "hmnrghts" data provided with the Monogan book (I placed it in my working directory already manually - otherwise
#I would need to write out the file path before the filename)

df <- read.table("./data/hmnrghts.txt", header=T, na="NA")
#header=T indicates that there are variable names at the top of the file as the first row. na="NA" says missing data are indicated by NA. 
#"./" indicates that the data is in a folder within the working directory

#Missing data are always "NA" in R, so if your data use some other value to indicate missing data (e.g., "999") you need to change it to NA
#(I usually just do this manually, but you can also recode specific variables as described later). 

#You should now have a data set called "df" in your global environment in the top right window. 

#####***csv#####

#To load pretty much any other sort of data set, you need to install and load the "foreign" pacakge. 

install.packages("foreign") 
library(foreign)

#R won't load Excel files - you need to save them as .csv files. Then you can load them like this: 

df2 <- read.csv("./data/UN.csv") #UN data set from Monogan book

#####***SPSS data file (.sav)#####

df3 <- as.data.frame(read.spss('./data/anes_timeseries_2016_sav/anes_timeseries_2016.sav', 
                                use.value.labels=F, use.missing=T)) 
#This data set is available under "Other data sets" on D2L"
#use.value.labels is usually set to False b/c in SPSS, you can assign labels to values (e.g., 1 might indicate "Strongly Disagree"); 
#we just want the numbers usually (if it is a text variable, it will still contain the text)
#use.missing converts SPSS missing values (-99 I think) to R missing values (NA)

#####***Stata data file (.dta)#####

df4 <- read.dta("http://j.mp/PTKstata") 
#You can also load data directly from a URL if available




#####Viewing Data Sets#####

#You can view the data set by clicking on it in that window or typing: 
View(df) 

#Warning: this can take very long and make R crash for very large data sets, so to just see the first 6 rows, type: 
head(df)
#or the last 6 rows...: 
tail(df)

#Or you can specify particular rows and/or columns in a couple of different ways...

#brackets are used to specify a subset of the data with the format, [rows, columns]
df[2, 3] #second row, third column (or, the "sdnew" value for Albania in this case)
df[1:10, ] #All columns for rows 1-10
df[ , 2:5] #All rows, columns 2-5
#for non-consecutive columns, use "c()"
df[ 1:10, c(1, 3:5, 8)]
#same with non-consecutive rows
df[ c(1, 7:8), ]
#You can also use the actual names (probably what you will do more often b/c that is what you are familiar with)
df[ 1:10, c("country", "military")] 
#The "names" of your rows are literally just consecutive numbers for now, but you can change them easily to one of the existing variables using the
#row.names command. 

#To do this you need to know how to specify a variable from a data set using "$". This is easy. "$" essentially is used in R to specify a component
#of an object. Sometimes it is used to specify a component of other sorts of objects, but in data sets, it is used to specify specific variables.
row.names(df) <- df$country #Here we are assigning the row names for the data set to correspond with the variable, "country"
row.names(df) 

#So now we can use specific names of countries to specify subsets of our data as well
df[ c("albania", "gambia", "fiji", "liberia", "soviet union(russia)"), 1:5]



#####Descriptive Statistics#####

#To examine descriptive statistics for the variables in your data set, there are some pretty handy built-in commands. 

#"summary" is used to get information about pretty much anything (can be used on objects and functions as well)

summary(df$democ) #minimum, 1st and 3rd quartiles, median, mean, maximum, and number of missing values
#No standard deviation, though? No problem: 
sd(df$democ, na.rm=T) #"na.rm=T" is necessary if there are any missing values otherwise this will just return "NA"

#What if you run summary on a text/categorical variable? 
summary(df$gnpcats) #Shows frequencies for each category as well as number of NAs

#You can also use "table" to obtain frequencies for each category, even for numerical variables

table(df$gnpcats) 
table(df$democ)

#Say you want to see a table of frequencies split by another variable

table(df$democ, df$gnpcats)
table(df$sdnew, df$democ, df$gnpcats) #you can add more to split by as well

#The aggregate function is great for getting descriptive statistics split by levels of a categorical variable
?aggregate
aggregate(df$democ, by=list(df$military), FUN=mean, na.rm=T) #mean
aggregate(df$democ, by=list(df$military), FUN=sd, na.rm=T) #SD


#####Recoding Variables#####

#It is often the case that you want to change the names of variables in your data set to be more intuitive. This is easy in R. 
#You can name variables whatever you want so long as there are no special characters (although periods are okay) - just like with objects. 
#BUT, here are some tips: 

# - Keep you variable names short and easy to type (minimize keystrokes, avoid strange combinations of characters), but also use
#names that are self-explanatory (e.g., "edu" instead of "education" or "ed.2017.version2.recoded")
# - Develop a consistent set of "rules" for recoding that you use for all you data sets (e.g., ".r" indicates reverse-coded rather than
  #indicating reverse-coded for some data sets but reordered for others)


#To recode a variable, we simply create assign "something" (can be an existing variable, a manipulation of an existing variable, or an entirely new 
#column that we make up) to a new object within the data set. You can simply use the same name as an existing variable, but this will OVERWRITE
#the pre-existing variable.

#There are several ways to do the same exact thing when it comes to recoding...

#Here, I will recode "democ" into a new variable called democ.r, which is democ but reverse-coded so that higher values equal lower levels
#of democracy instead of higher levels of democracy. 
table(df$democ)

#Option 1:
df$democ.r <- 10 - df$democ
table(df$democ.r) #Just checking to see if it worked

#Option 2: 
library(car)
?recode #uses the car package
df$democ.r <- df$democ
recode(df$democ.r, "0=10; 1=9; 2=8; 3=7; 4=6; 5=5; 6=4; 7=3; 8=2; 9=1; 10=0")
table(df$democ.r)

#Option 3: 
# the "ifelse" command is a built-in command that is essentially a way to recode specific values differently and does not require any packages.
#Some people use it more than others (I tend to use it a lot). The command has 3 statements: a logical statement, what to return if the logical 
#statement is true for that row, and what to return if the logical statement is false for that row. 

table(df$V162031x) #Just so I can see what the variable originally looks like
df$V162031x.v2 <- ifelse(df$V162031x < 0, NA, 
                         df$V162031x)
table(df$V162031x.v2)  #In ANES data, they often use negative numbers to indicate missing 
#values, so all I have done is make all values less than 0 missing, and left everything 
#else the same as in the original variable. Literally, the code says "if V162031x is 
#less than 0, change it to NA, otherwise give it the value of that row for the V162031x 
#column"

#Another example might be that I want to combine some range of values. I can "branch" or "layer" the ifelse command to do this: 
df$V162034a.v2 <- ifelse(df$V162034a < 0, NA, 
                         ifelse(df$V162034a == 1, 1, 
                                ifelse(df$V162034a >= 2 & df$V162034a <= 7, 2, 
                                       3)))
table(df$V162034a.v2) #This code again makes every value below 0 missing, but then it 
#goes on to make all values that equal 1 to be 1, all values between 2 and 7 (including 
#2 and 7) to be 2, and everything else (in this case values above 7) to be 9. Literally, 
#the code is saying "if V162034a is less than 0, make it NA, otherwise... if V162034a 
#equals 1, make it 1, otherwise... if V162034a is greater than or equal to 2 AND less 
#than or equal to 7, make it 2, otherwise... make it 3. Using ifelse like this can get 
#tricky fast and it is important to pay attention to commas and parentheses. 
#NOTE: < means less than, > means greater than, <= means less than or equal to, >= 
#means greater than or equal to, == means equal to (DO NOT USE just '='), & means AND, 
#and | means OR."




#####Univariate Visualizations#####

#Histogram
hist(df$democ)
hist(df$democ, col="red") #change the color
#Add labels
x <- df$democ 
h<-hist(x, col="red", xlab="Democracy", ylab="Synonym for Frequency?",
        main="Histogram with Labels") 

#Density plot
plot(density(df$democ, na.rm=T)) #won't run without na.rm=T if there are missing values

#Density plot separate by group (using ggplot a bit)
install.packages("ggplot2")
library(ggplot2)

table(df$civ_war)
#First, a tiny bit of data manipulation so this works. We need "civ_war" to be read as a "factor" instead of a numerical variable. 
df$civ_war_factor <- as.factor(df$civ_war)
levels(df$civ_war_factor)=c("No Civil War", "Civil War")
table(df$civ_war_factor)
levels(df$civ_war_factor)

ggplot(df) + geom_density(aes(x = democ, color = civ_war_factor))
#Make it prettier
ggplot(df) + geom_density(aes(x = democ, fill = civ_war_factor), alpha=.2)
#Add more and combine the ideas
ggplot(df) + geom_density(aes(x = democ, fill = gnpcats), alpha=.2) + facet_wrap(~civ_war_factor, ncol=2, scales="free")
#ncol changes the organization of "facets" (or panes)


#Or you can do the same with lattice
install.packages("lattice")
library(lattice)

densityplot(~ democ, group = civ_war_factor, data = df, auto.key = TRUE)
densityplot(~ democ | civ_war_factor, data = df) #You can also put in separate panels instead of overlaying
densityplot(~ democ | civ_war_factor, group = gnpcats, data = df, auto.key = TRUE) #Add more and combine the ideas









#####Quitting R#####

#Quitters never win, and winners never quit. But if you want to quit your R session: 

q()











