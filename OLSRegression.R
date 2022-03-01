#Frank J. Gonzalez
#School of Government and Public Policy
#University of Arizona
#fgonzo@email.arizona.edu
#POL596A
#Fall 2018


#OLS regression is the primary workhorse of quantitative research, especially in Political Science. Essentially, linear regression (a broader term for
#linear models, of which OLS is the most common) allows the researcher to identify the "line of best fit" that describes the relationship between, and
#OLS is particularly useful (rather than just a bivariate correlation) when you want to identify the *unique* effects of more than one independent
#variable on a dependent variable (note: the use of the term "effects" here can be interpreted as misleading by some, as it is not necessarily the 
#case that the IVs "cause" the DV - it's really more of a "unique relationship"). So, variables x and z may both be significantly related to y, but if 
#x and z are picking up on the same "part" of y (i.e., the same segment of variation), then they will display no *unique* effects. 

#For example, we may want to see the relationship between income and vote choice (regressing vote choice on income, which is the way of saying 
#vote choice is the DV and income is the IV), but we may also want to be sure the effect of income is not really just explained by the effect of, say, 
#education (just as an example). So, we would include both income and education in a regression predicting vote choice to see if income has a *unique*
#effect "controlling for" education. 

#Importantly, using a linear regression comes with various statistical assumptions as you have discussed in POL681. So, your decision to use OLS comes 
#with those assumptions, and you will learn later about other, more advanced statistical models that can take into account violations of the OLS 
#assumptions. 

#In R, we will usually use the "lm" command. We will go over what happens "under the hood" to make this command work in POL682, and will even
#write a function that does a linear regression "by hand." But for now, let's just use the lm command and make sure we understand it. 

#####Importing some data#####

#Let's start with that "tennessee" data set from before. 

Y<-c(.808,.817,.568,.571,.421,.673,.724,.590,.251) #Republican share of the 2-party vote in 2010
X2<-c(.29,.34,.37,.34,.56,.37,.34,.43,.77) #Obama's share of 2-party vote in 2008
X3<-c(4.984,5.073,12.620,-6.443,-5.758,15.603,14.148,0.502,
      -9.048) #Degree of Republican financial advantage
X1 <- rep(1,9)
index <- c(1:9)

x <- cbind(index,Y,X1,X2,X3)
X <- as.data.frame(x)

#####Using "lm" #####

#Okay, so we have some variables we might want to throw into an OLS regression. Let's say we wanted to predict the Republican share of the 
#2-party vote in 2010 with Obama's share of the vote in 2008, BUT controlling for the Republican financial advantage. Here's how that would
#look: 

#I usually create an object containing the results of my models - you don't have to do that by I think it's easier to look at different aspects
#of the results by calling that object rather than retyping the whole command. 

?lm
#There are several different ways to write this out: 
#Option 1:
lm1 <- lm(X$Y ~ X$X2 + X$X3)
#after "lm(", you put the regression formula, which is the DV on the left side of the "~" and then the IVs on the right side, separated by 
#"+". 
#If using the "$" method, you can just add the data frame name and then "$" before each variable name in your formula to specify the data seet
lm1 <- lm(Y ~ X2 + X3, data=X)
#Or you can just include the variable names and specify the data set with "data="
lm1 <- with(X, lm(Y ~ X2 + X3))
#Or you can use "with(" to specify the data set name
lm1 #Just running the object name will give you the coefficients
summary(lm1) #summary gives you coefficients, standard errors, t-values, and p-values
#We can see here that X2 is significant and negative controlling for X3, which is not significant. 

#####IMPORTANT NOTES#####

#First, in OLS, your DV needs to be continuous (technically, the command will work on a binary outcome/dummy variable (0 or 1) but this really
#isn't appropriate). 

#Second, the type of variable each IV is matters. 

#For continuous IVs, just put the variable name as an element of the formula and you are fine. lm will estimate the effect of increasing levels of that
#variable. 

#For factor/categorical variables, you need to recode your variable to that it is a set of dummy variables (0 or 1) for each category, so for example, 
#race might be a variable that is 1 for White and 0 for non-White, another variable that is 1 for Black and 0 for non-Black, another variable that is 
#1 for Asian and 0 for non-Asian...and so on depending on how many categories you want to code for. However, there is always a *reference category*, 
#which is the category against which all other categories are compared, and this category should always be omitted from the model!

#In R, you can do this by literally creating separate dummy variables for each category, or (preferably) by converting the variable to a factor variable
#using "as.factor", which will force lm to see the variable as it's constituent categories/dummy variables, and will automatically use whatever is either 
#coded as 0 or designated to be the reference category (defaults to first alphabetically but can be explicitly changed using "relevel"). 

#Example: 

#####ANES DATA#####

setwd("C:/Users/fgonzo/Documents/data")
library(foreign)
df <- as.data.frame(read.spss('anes_timeseries_2016.sav', 
                              use.value.labels=F, use.missing=T)) 

df$id <- df$V160001
df$vote <- df$V162031x
df$vote_choice <- df$V162034a
df$ft_blm <- df$V162113
df$soc_class <- df$V162132
df$age <- df$V161267
df$ft_Dems <- df$V162078 #I added this one for later
df$ft_Pope <- df$V162094 #I added this one for later

summary(df$id)

table(df$vote)
df$vote.r2 <- ifelse(is.na(df$vote), NA, 
                    ifelse(df$vote < 0, NA, 
                           df$vote))
table(df$vote.r2)
df$vote.r <- as.factor(df$vote.r2)
levels(df$vote.r)=c("No", "Yes")
table(df$vote.r)

table(df$vote_choice)
df$vote_choice2 <- ifelse(is.na(df$vote_choice), NA, 
                          ifelse(df$vote_choice < 1, NA, 
                                 ifelse(df$vote_choice == 1, 0, 
                                        ifelse(df$vote_choice == 2, 1, NA))))
table(df$vote_choice2)
df$vote_choice2 <- as.factor(df$vote_choice2)
levels(df$vote_choice2)=c("Clinton", "Trump")
table(df$vote_choice2)

summary(df$ft_blm)
df$ft_blm.r <- ifelse(is.na(df$ft_blm), NA, 
                      ifelse(df$ft_blm < 0, NA, 
                             ifelse(df$ft_blm > 100, NA, 
                                    df$ft_blm)))
summary(df$ft_blm.r)

summary(df$ft_Dems)
df$ft_Dems.r <- ifelse(is.na(df$ft_Dems), NA, 
                       ifelse(df$ft_Dems < 0, NA, 
                              ifelse(df$ft_Dems > 100, NA, 
                                     df$ft_Dems)))
summary(df$ft_Dems.r)

summary(df$ft_Pope)
df$ft_Pope.r <- ifelse(is.na(df$ft_Pope), NA, 
                       ifelse(df$ft_Pope < 0, NA, 
                              ifelse(df$ft_Pope > 100, NA, 
                                     df$ft_Pope)))
summary(df$ft_Pope.r)

table(df$soc_class)
df$soc_class.r2 <- ifelse(is.na(df$soc_class), NA, 
                         ifelse(df$soc_class < 0, NA,  
                                df$soc_class))
table(df$soc_class.r2)
df$soc_class.r <- as.factor(df$soc_class.r2)
levels(df$soc_class.r)=c("Lower", "Working", "Middle", "Upper")
table(df$soc_class.r)

summary(df$age)
df$age.r <- ifelse(is.na(df$age), NA, 
                   ifelse(df$age < 0, NA,  
                          df$age))
summary(df$age.r)

#####lm with ANES#####

#Let's predict feelings toward BLM with age, whether or not one voted, and social class. 

lm1 <- lm(ft_blm.r ~ age.r + vote.r + soc_class.r, data=df)
summary(lm1)

df$soc_class.rx <- relevel(df$soc_class.r, "Upper")
table(df$soc_class.rx)

lm1 <- lm(ft_blm.r ~ age.r + vote.r + soc_class.rx, data=df)
summary(lm1)

#Want a cool table that you can throw into word (or latex if type="latex")
#out="word" saves a Word file to the working directory too!
install.packages("stargazer")
library(stargazer)
stargazer(lm1, type="text", out="word")
?stargazer


#####Visualizing lm results#####
install.packages("visreg")
library(visreg)
visreg(lm1, "soc_class.rx") #Automatically detects continuous versus factor 
#variables











