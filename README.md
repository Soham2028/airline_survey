## Airline Survey

1. Introduction

Cheapseats Airlines maintains a set of survey data related to how customers feel, and multiple variables associated to their domestic flights. Cheapseats Airlines stood out as one of the larger airlines with 26k observations reported. Due to the law of large numbers, we believe that the dataset provided on which Cheapseats analysis is performed is statistically sufficient for RedPanda consultants to perform their analysis.

2. Understanding the Data

The initial data set contained multiple airlines data and values that proved a hindrance when performing analysis. The dataset contained various data types, including integer, factor, and character that often confused RStudio. In order to generate a dataset that is most usable, we generated the following set of assumptions.

(1) Null values were few in number compared to the overall data, therefore the team extracted all survey data observations that contained null values. In addition, most variables that were used while analyzing are with no null values.
(2) The data proved initially to be to large and thus the team agreed to only focus on Cheapseats Airlines as the total sample population of Cheapseats closely models the overall data set.
(3) Where values fell within the metadata, team members used the integer values within their analysis, this provides a more complete dataset.
(4) For the purpose of this proposal, any reference to West Airlines, being a subsidiary of Cheapseats, is used as a reference point.
(5) To effectively create an increase in the overall satisfaction, a high satisfaction score is benchmarked. The benchmark for the satisfaction score, for purposes of the assessment, will be greater than or equal to 4. Thus, customers with a survey rating of 4 or higher are classified as giving a high rating. Ratings of 3 are average and a rating of 1 or 2 is below average.
The survey data was initially analyzed as a whole data set. This generated a good understanding
of the baseline for all the airlines. After a baseline was understood, the team focused on one Airline to perform the analysis over again. This was decided upon as it is easier to help one airline than the conglomerate. After the decision was agreed upon, the survey data was cleaned and a subset of data was created just for Cheapseat Airlines. The following report covers the steps team Red Panda followed from understanding the data to providing valid and usable recommendations for Cheapseat Airlines.

3. Scope & Business Questions

Scope:

(1) Improve overall customer satisfaction
(2) Generate actionable insight for Cheapseats Airlines.
Problem Statement:
Given a dataset of over 130,000 survey responses, what actionable insights can be understood to help Cheapseats Airlines to improve their customer satisfaction
Purpose:
Team Red Panda will analyze a dataset consisting of 130,000 responses within the course of 8 weeks in order to provide actionable insight for Cheapseat Airlines to improve overall customer satisfaction.
Business Questions:
1. Business Rule # 1 - ​All satisfied customers will rate the airlines with a rating of 4 or higher (Average - Very High) while all unsatisfied customers will give a rating less than or equal to 3.
2. Business Rule # 2 - ​Incentives shall be distributed in the event of delayed flights.
3. Business Rule # 3 - ​Ensure senior citizen passengers are properly cared for while flying our
airline.
4. Business Rule # 4 - ​Fill as many seats per each flight as possible, and this includes complimentary
upgrades when seats are not filled and available.
5. Business Rule # 5 - ​Any flight more than 5 min delayed upon departure or arrival is considered
"delayed".
6. Business Rule # 6 - ​Every customer should sign up for the travel type status program (blue,
silver, gold, platinum).

Data Questions:

1. Why CheapSeats Airlines?
2. Is age a factor in lower ratings or higher ratings within the data set?
3. Does a person’s travel type affect on the rating they will give during the survey?
4. How many flights are there per months / day? Do delayed flights have a significant effect on customer ratings?
5. Is there a gender bias in customer satisfaction ratings?
6. What class is most often traveled and does the class have an effect on the customer rating?
7. Does the airport location of the airport have an impact overall customer satisfaction? Which cities were traveled to most on any given day and is there a pattern of lower ratings based on the most
visited city?
8. What is the distribution of satisfaction ratings per rating?
9. Does the number of times a person flys impact their overall satisfaction rating?
10. Which travel type gives the highest satisfaction rating and how much does travelType affect the
overall satisfaction score?
