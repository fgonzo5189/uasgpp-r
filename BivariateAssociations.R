#Frank J. Gonzalez
#School of Government and Public Policy
#University of Arizona
#fgonzo@email.arizona.edu
#POL596A
#Fall 2018

#Eventually the "prize at the end of the rope" in intro to stats courses is to be able to do linear regression. However, 
#it is important first to understand bivariate associations, as linear regression rests on essentially a whole bunch
#of bivariate associations (sort of). Plus, there are going to be many times when you do not need to or want to do
#a full linear regression, and you simply want to obtain the relationship between two variables ignoring all other 
#factors. 

#The type of bivariate test you do depends on the types of variables you are dealing with. Here are the three main types
#of variable pairs you may be dealing with and the appropriate bivariate test for each (along with the coefficient
#you use for testing significance for each in parentheses):

#1) two continuous variables: correlation (Pearson's r)
#2) two categorical variables: cross tabulation (chi-square)
#3) one continous and one categorical: t-test/ANOVA/differences of means (F-test/t-test)

#We will not get into the matrix algebra behind each of these here - that is for POL682. For now, we will just 
#go over the "canned" commands R offers for each of these tests, as well as how to visualize the results of each.

#####Loading in some data#####

#Let's bring in the ANES 2016 data again, and clean it up like we did before for Assignment 2:

setwd("/Users/fgonzo/Dropbox/Teaching/Teaching 2018-2019/Fall 2018/POL596A/Scripts")
library(foreign)
df <- as.data.frame(read.spss('./data/anes_timeseries_2016_sav/anes_timeseries_2016.sav', 
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
df$vote.r <- ifelse(is.na(df$vote), NA, 
                    ifelse(df$vote < 0, NA, 
                           df$vote))
table(df$vote.r)
df$vote.r <- as.factor(df$vote.r)
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
df$soc_class.r <- ifelse(is.na(df$soc_class), NA, 
                      ifelse(df$soc_class < 0, NA,  
                                    df$soc_class))
table(df$soc_class.r)
df$soc_class.r <- as.factor(df$soc_class.r)
levels(df$soc_class.r)=c("Lower", "Working", "Middle", "Upper")
table(df$soc_class.r)

summary(df$age)
df$age.r <- ifelse(is.na(df$age), NA, 
                         ifelse(df$age < 0, NA,  
                                df$age))
summary(df$age.r)


#####Correlation#####

#Let's look at the correlation between age and feelings toward blm

#Want to look at:
#cor -> shows the correlation between the variables
#p-value -> shows you whether or not it is significant (p < .05 means significant)

cor.test(df$age.r, df$ft_blm.r, na.rm=T)
#This shows a significant negative correlation (r = -0.101, p < .001) 

#Do this for every pair of variables you are interested in seeing the relationship between

#Or if you want a table with a whole bunch of correlations, you can do this:
#however, 
#it does not show you the p-values...the variable names are what is in quotations
cordat <- as.data.frame(df[c("age.r", "ft_blm.r", "ft_Dems.r", "ft_Pope.r")]) 
head(cordat)
cors <- cor(cordat, use="pairwise.complete.obs")
cors #note: this is a symmetric matrix!

#####*****Visualizing a Correlation#####

#Often, scatterplots are used to visualize the correlation between two variables:

plot(df$age.r, df$ft_blm.r, xlab="age",ylab="Feelings toward BLM")
#But that is often pretty ugly if you have many data points; you can use the scatterplot function from 'car'
install.packages("car")
library(car)
?scatterplot
scatterplot(df$age.r, df$ft_blm.r, regLines=T, grid=F, smooth=T, 
            xlab="age", 
            ylab="Feelings toward BLM", title="")

#or you can use the scatter.hist command in the 'psych'
#package, which has many other cool options
install.packages("psych")
library(psych)
?scatter.hist
scatter.hist(df$age.r, df$ft_blm.r, smooth=T, ab=T, correl=F, density=T, ellipse=F, pch=16,cex=0.4 ,
             digits=2, method="pearson", xlab="age", 
             ylab="Feelings toward BLM", title="")
#Try playing around with some of the options!
#ab=T puts the straight line on the graph and smooth=T puts the curved one on the graph

#Or ggplot, my favorite: 
install.packages("ggplot2")
library(ggplot2)
ggplot(df, aes(x=age.r, y=ft_blm.r)) +
  # geom_point(shape=16) +    # Use dense circles (commented it out for now so there are no dots at all)
  geom_smooth(method=lm,   # Add linear regression line
              se=T)  +   # set to F to get rid of shaded confidence region
  geom_rug(col=rgb(.5,0,0,alpha=.2)) #This adds a rug plot to each axis (pretty much conveying distribution
  #of each variable like a histogram would)
#There are many other options to play with using ggplot
#If you really want histograms but still with the flexibility of ggplot, I'm sure there is a way (try 
#ggMarginal in the ggExtra package), but I haven't perfected it yet so I have not included it here.


#####Crosstabulation#####

#Let's look at whether one's social class is a good indicator of who they voted for

#First, the easiest way to do this is to use the gmodels package:
install.packages("gmodels")
library(gmodels)

table(df$vote_choice2, df$soc_class.r)
table(df$soc_class.r, df$vote_choice2)

#The 'CrossTable' command allows you to look at proportions within each cross-section of the two variables 
#and calculate if those proportions are significantly different from one another using a chi-square test
CrossTable(y=df$vote_choice2,x=df$soc_class.r,prop.c=F,prop.t=F,
           prop.chisq=F,chisq=T,format="SPSS")
#y = the column variable, x = the row variable (DV should be columns and IV should be rows) 
#'prop.c' gives you the proportion of each column, which we usually are not interested in
#'prop.t' gives you proportion of the total sample - also not usually of interest 
#'prop.chisq' gives you the contribution to the chi-square - which we aren't usuallly interested in either
#'format' gives you percentages if you use "SPSS" and proportions if you use "SAS"

#There is a significant difference across cells (according to the p-value for 
#the chi-square) - it seems like the upper class was more likely to vote 
#for Clinton, whereas the lower class was slightly more likely to vote for Trump

#What about the pairwise differences (i.e. differences between each pair of categories)? 
#Well the easiest thing to do is use the results from above to use "prop.test" to see if 
  #the chi-square test shows significant differences for the pair you are interested in

##the first two numbers represent the N of the categories, the last 
##two numbers represent the population N
#This example is for the proportion of Working Class individuals who voted for Clinton vs Trump
prop.test(x=c(159,166), n=c(325,325),
          alternative="two.sided",
          conf.level=.95)
#How about the proportion of Clinton voters who were Working Class vs Trump voters who were Working Class?
prop.test(x=c(159,166), n=c(474,444),
          alternative="two.sided",
          conf.level=.95)



#####*****Visualizing a crosstabulation#####

#People often depict a crosstab simply with a table with the chi-square test results beneath it, similarly to
#what R automatically generates in the console

#####Difference of Means/ANOVA or t-test#####

#There are two ways you might want to compare means: 
#1) t-test - independent samples (i.e. separate cases/individuals/countries/whatever)
#2) t-test - dependent samples (i.e. the same cases/individuals/countries/whatever)
#Then, you can also do an ANOVA in each of these ways as well - it does the same thing except uses an 
#F-test instead of a t-test; when to do one versus the other really depends entirely on who you are communicating
#with; psychologists tend to use ANOVA whereas political scientists tend to use t-test, for example
#HOWEVER, a benefits of ANOVA is that you can look at differences across more than 2 groups

#Let's look to see if feelings toward blm differ, on average, between those who voted and those who did not
#This is an independent samples test b/c the people who voted are separate individuals from those who did not

summary(df$ft_blm.r)
summary(df$vote.r)
?t.test
t.test(ft_blm.r~vote.r,data=df,alternative="two.sided",var.equal=F)
#The first argument in the command is the "formula", which is just "DV ~ IV" or "Continuous variable ~ Grouping Variable"; 
#'alternative' is whether you are using a two-sided or one-sided significance test (see POL682), and 
#IMPORTANTLY, we decide here whether or note we want to assume that variances are equal. Here, we do not assume so
#("var.equal=F")

#Whether or not we should assume variances are equal depends on whether or not the groups in our categorical variable 
#are entirely independent of one another (i.e. are some categories potentially "closer" to one another?); the only
#times we generally assume the variances *are* equal are in experiments where we have randomly assigned people to 
#different conditions/groups, and so we *know* via the process of randomization that there is zero correlation between
#the errors/variances of being in each condition

#Let's now look to see if feelings toward blm differ significantly from feelings toward Democrats
#This is now a fundamentally different question b/c the variances are not just unequal but are now likely 
#to be strongly correlated with one another (b/c they are from the same person/country/etc.)

#So we do a dependent samples t-test:

t.test(df$ft_blm.r,df$ft_Dems.r,paired=T,alternative="two.sided") #paired=T is the main addition here
#There is a significant difference of 4.65 points between the two
#In which direction, you ask? 
summary(df$ft_blm.r)
summary(df$ft_Dems.r) #people feel warmer toward BLM


#####ANOVA#####

#Let's do the same tests but with ANOVA and more than two groups in our categorical variable: 
?aov
a1 <- aov(df$ft_blm.r~df$soc_class.r)
summary(a1)
#As simple as that - there is no significant omnibus difference across categories
#Note: this is me putting the "aov" function inside the "summary" function, which is the same as me creating 
  #an object that is the result of the "aov" function and then using summary on that object separately.
#What about the pairwise differences (i.e. differences between each pair of categories)? 
?TukeyHSD 
#Tukey's HSD is the name of a significance test for identifying whether pairwise differences across 
#categories of a variable are significantly different from one another - we use Tukey's HSD to account for the fact
#that as the number of categories increases, the probability of at least one of them being significant at p < .05 
#simply by chance increases. There are other options too like Bonferonni, but Tukey is pretty generally accepted. 
#We will talk more about this in 682 and 683, but for now just know this is a way to get pairwise differences.
aov1 <- aov(df$ft_blm.r~df$soc_class.r) #this time it's probably easiest to just make the aov its own object
TukeyHSD(aov1) 
#This shows all possible pairs, the mean difference between each, and the p-value for each pairwise test 
#(lwr and upr indicate the lower and upper bounds of the 95% confidence intervals)

#A "repeated measures" ANOVA is what we would do to look at "dependent samples" as with the t-test, but to 
#do this, we actually need to manipulate our data a bit so that there is a separate row for each person for 
#each "time point" (or variable) - in this case, a row for their score for BLM and a separate row for their score for 
#Dems, and then another separate row for their score for the Pope; so each individual in our dataset will have two
#rows

#Often, this is how you will handle longitudinal/panel data in which you have a "score" for various time points for a single
#case (individual, country, etc.)

#This is called "stacking" the data. I am going to create a subset of the data that is just the variables I am interested
#in to make this more manageable 

dfx <- df[c("ft_blm.r", "ft_Dems.r", "ft_Pope.r")]
head(dfx)
dfx_long <- reshape(dfx, varying=list(c("ft_blm.r", "ft_Dems.r", "ft_Pope.r")), 
                      v.names=c("value"), timevar="measure", 
                      idvar=c("ID"), 
                      time=c("BLM", "Dems", "Pope"), 
                      direction="long")
head(dfx_long)
tail(dfx_long)
summary(dfx_long$value)
hist(dfx_long$value)
sd(dfx_long$value, na.rm=T)
#You can rename/recode variables in this new data set just like you would with any data set
#I'd like to actually make the "measure" variable a factor, because by default it might not 
#necessarily do that
class(dfx_long$measure)
table(dfx_long$measure)
dfx_long$measure <- as.factor(dfx_long$measure)
levels(dfx_long$measure)=c("BLM", "Dems", "Pope")
table(dfx_long$measure)

summary(aov(dfx_long$value ~ dfx_long$measure + Error(dfx_long$ID)))
#NOTE: the "Error(...)" term is necessary for a repeated measures ANOVA. With a t-test, you indicate that the 
#variances of your dependent variable are correlated with the "paired=T" argument; however, in anova, there is 
#no such command. Instead, we use "Error(" to denote that the error terms (i.e., variances) of our dependent variable
#are correlated based on this other variable - in this case, "ID", which is the participant's ID number. In our 
#"long" data set, the ID variable is the same for every two rows belonging to the same person, which is why we use 
#that variable for our Error argument. If our rows were instead different years corresponding to the same country, we
#would use whatever variable represents "country" instead of "ID" here. 
aov2 <- aov(dfx_long$value ~ dfx_long$measure)
TukeyHSD(aov2)

#This shows there is a significant difference between the variables (F = 749.00, p < .001)
#But in what direction? 
aggregate(dfx_long$value, by=list(dfx_long$measure), FUN=mean, na.rm=T) 

#How about pairwise differences? 
#Well, this is where it gets a bit complicated because Tukey's HSD does not apply to "repeated measures" ANOVA, where
#the samples are dependent... in order to properly account for the dependent samples here, we need to utilize a 
#different command in conjunction with another package (well, several packages): 
install.packages("lme4")
install.packages("lmerTest") #lmerTest just makes sure the output below gives you p-values
library(lme4)
library(lmerTest)
lme1 <- lmer(value ~ measure + (1|ID), data=dfx_long)
summary(lme1)
#This is "essentially" doing the same thing as the ANOVA above, except in a fancier type of model, called a mixed 
#effects model (you will also use this package to conduct multi-level/hierarchical models - see POL683 (I think))
#Don't worry about anything for now except that this is another way of running the ANOVA model above
#As you'll see, the results are already a bit different. You just need to focus on the "fixed effects" section, where
#you should see a separate coefficient for each category of the grouping variable except for one. 
#These coefficients represent the different between the shown category and the missing category (referred to as the 
#reference category). 
#So one way to look at all the pairwise differences is to simply look at these results, then "relevel" the grouping 
#variable so that a different category is the "reference category" and do the same analysis: 
dfx_long$measure2 <- relevel(dfx_long$measure, "Dems")
lme2 <- lmer(value ~ measure2 + (1|ID), data=dfx_long)
summary(lme2) #and here we have the missing pairwise comparison (Pope versus Dems)
#Or, maybe you prefer not to run the same analysis twice; you can also use the "glht" command in the "multcomp" 
#package - it let's you test linear hypotheses within essentially any model
install.packages("multcomp") 
library(multcomp)
?glht
summary(glht(lme1, linfct=mcp(measure = "Tukey")), test = adjusted(type = "bonferroni"))
#Now we have all pairiwse comparisons based solely on the first model we ran
#"Bonferroni" is one of many options, but probably the most popular - it just determines the method of 
#correcting for multiple pairwise comparisons (i.e., having >2 categories)


#####*****Visualizing mean differences across groups#####
#Usually, mean differences across groups are shown with a bar plot or density plot. 
#Sometimes people use a dot-plot in which dots are used instead of bars - dot-plots are more common for repeated measures

#####**********Independent samples#####
#***************Density plot example: 
library(ggplot2)
df1 <- data.frame(df$ft_blm.r, df$soc_class.r) #making a subset of the data first
head(df1)
ggplot(data=subset(df1, !is.na(df.soc_class.r)), aes(df.ft_blm.r)) +
  geom_density(aes(group=df.soc_class.r, fill=df.soc_class.r), alpha=.3, show.legend=T) +
  theme_bw() + 
  xlab("Feelings toward BLM") +
  theme(text = element_text(size=26)) + 
  ggtitle("") +
  theme(plot.title = element_text(face="bold"),
        legend.background = element_rect(colour="grey80"), 
        legend.position = c(0.8, 0.7)) +
  guides(fill = guide_legend(title = "Social Class"))
#usually the first argument after ggplot( is just the name of the dataframe (e.g., df1), but sometimes ggplot
#will hate you and try to include NAs as their own category to plot, so you need to subset the data set to 
#exclude rows where the variable (here, soc_class) is missing (!is.na(x) means "where x is not missing))

#***************Bar plot example: 
#For this (and for dot plots), you need to create an object containing the summary information (mean, sd, ci) for 
#the variable for each group before plotting (otherwise it will plot the count/frequency for each category). 
#There are a few ways to do this, but the way I do it (and thus the way I show you :-)) is to build a function 
#that outputs a matrix with the necessary summary information. I "stole" this function from some forum years ago
#and it has worked ever since
#I am not going to type out the entire function below (there are shorter versions of this but the one I "stole"
#is flexible with regard to various types of data and problems you may encounter). Instead, you need to download
#the "SummarySe_script.R" file from D2L into your working directory folder. Then, run the "source" command, which
#"silently" runs the selected script in the background ("source" is quite useful for a lot of things where you
#don't want to have to open up a separate script and run every command in it every time, but know that if there
#are any errors in the script your are "sourcing", it will not work. It literally runs every line in the sourced
#script line-by-line)
source("SummarySE_script.R")
#Now you can apply the "summarySE" command (which was created in the sourced script) to our data set
summData <- summarySEwithin(data=subset(df1, !is.na(df.soc_class.r)), measurevar=c("df.ft_blm.r"), 
                            withinvars=c("df.soc_class.r"), na.rm=T, conf.interval=.95)
#See above on why I needed to "subset" the data
summData 
#Here you should see a matrix with one row per category of our grouping variable (social class), and then 
#columns corresponding to the name of the category, the frequency in each category, the mean of "ft_blm" for each
#category (the "_norm" column should be identical and is only relevant in weird cases you don't need to worry about), 
#the standard deviation for each category, the standard error for each category, and the confidence interval for each
#category

#Now, we can use ggplot to create a bar plot based on the summary information!
ggplot(summData, aes(x=df.soc_class.r, y=df.ft_blm.r)) +
  geom_bar(position=position_dodge(), stat="identity", width=.8) + 
  geom_errorbar(position=position_dodge(.2), width=.2, aes(ymin=df.ft_blm.r-ci, ymax=df.ft_blm.r+ci)) +
  coord_cartesian(ylim=c(0, 100)) + 
  scale_y_continuous(breaks=seq(0, 100, 10)) +
  theme_bw() + 
  xlab("Social Class") +
  theme(text = element_text(size=26)) + 
  ylab("Feelings toward BLM") +
  ggtitle("")  


#***************Dot plot example: 
#Well, now that you know how to do the bar plot function, you essentially know how to also do the dot
#plot version. You need to use the "summarySEwithin" command just like above, which resulted in the 
#summData matrix of summary information for the variables. Then you just make a ggplot but using 
#"geom_line" and "geom_point" instead of "geom_bar"
ggplot(summData, aes(x=df.soc_class.r, y=df.ft_blm.r)) +
  geom_line(group=1) + 
  geom_point() + 
  geom_errorbar(position=position_dodge(.2), width=.2, aes(ymin=df.ft_blm.r-ci, ymax=df.ft_blm.r+ci)) +
  coord_cartesian(ylim=c(0, 100)) + 
  scale_y_continuous(breaks=seq(0, 100, 10)) +
  theme_bw() + 
  xlab("Social Class") +
  theme(text = element_text(size=26)) + 
  ylab("Feelings toward BLM") +
  ggtitle("")  
#Get rid of the "geom_line(group=1)" argument if you don't want the line connecting the dots for each group



#####**********Dependent samples#####
#NOTE: the same things apply here as did above regarding density vs bar vs dot plots  for independent samples above. 
#That is, the below code for bar plots and dot plots utilizes the "summarySEwithin" function as discussed above
#The main different between the code below and the code above is that below we reference the "long"/"stacked" data set
#that we created to do the repeated measures ANOVA

#***************density plot example: 
ggplot(data=dfx_long, aes(value)) +
  geom_density(aes(group=measure, fill=measure), alpha=.3, show.legend=T) +
  theme_bw() + 
  xlab("Feelings toward [group]") +
  theme(text = element_text(size=26)) + 
  ggtitle("") +
  theme(plot.title = element_text(face="bold"),
        legend.background = element_rect(colour="grey80"), 
        legend.position = c(0.8, 0.7)) +
  guides(fill = guide_legend(title = "Group"))

#***************bar plot example: 
#Remember to "source" the "SummarySE_script.R" file as shown above; otherwise R won't know what 
#"summarySEwithing" means
summData2 <- summarySEwithin(data=dfx_long, measurevar=c("value"), 
                            withinvars=c("measure"), na.rm=T, conf.interval=.95)
#Note I did not need to "subset" my data here b/c there are not missing values for my grouping variable in this case
summData2 
ggplot(summData2, aes(x=measure, y=value)) +
  geom_bar(position=position_dodge(), stat="identity", width=.8) + 
  geom_errorbar(position=position_dodge(.2), width=.2, aes(ymin=value-ci, ymax=value+ci)) +
  coord_cartesian(ylim=c(0, 100)) + 
  scale_y_continuous(breaks=seq(0, 100, 10)) +
  theme_bw() + 
  xlab("Group") +
  theme(text = element_text(size=26)) + 
  ylab("Feelings toward [Group]") +
  ggtitle("")  


#***************Dot plot example: 
ggplot(summData2, aes(x=measure, y=value)) +
  geom_line(group=1) + 
  geom_point() + 
  geom_errorbar(position=position_dodge(.2), width=.2, aes(ymin=value-ci, ymax=value+ci)) +
  coord_cartesian(ylim=c(0, 100)) + 
  scale_y_continuous(breaks=seq(0, 100, 10)) +
  theme_bw() + 
  xlab("Group") +
  theme(text = element_text(size=26)) + 
  ylab("Feelings toward [Group]") +
  ggtitle("")  
#Get rid of the "geom_line(group=1)" argument if you don't want the line connecting the dots for each group





