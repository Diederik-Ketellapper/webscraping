# WEBSCARPPING THE TOP 4 BETTING WEBSITES IN EUROPE
#### Preface
This project aims to showcase the adquired skills during the course MAP 531 Introduction to R of the master's degree MSc Data Science for Business. The main goals of this project is to use and implement the different R capabilities shown in class, but at the same time develop a tool which may have some practical interest for the students. We decided to learn more on the online betting market in Europe. Mainly we dived into the different odds offered across the popular betting websites.

For this project we are going to use the decimal odds format, for more information about the different odds formats and what they mean the reader is encouraged to check: https://help.smarkets.com/hc/en-gb/articles/214071849-What-are-the-different-betting-odds-formats-

### Introduction
On the past few years, online betting has experienced a boom that has lead to proliferation of websites offering this service. The question that arises then,  is there any difference across websites regarding the odds? Or all of them offer the same odd for a given bet and the main difference might be other services the different portals offer?

In order to give an answer to this question, the first thing to do is to analyze how odds are defined by bookmakers. We are going to make a really quick introduction on bookmaking.
Usually the odds of a particular bet are defined by the bookmaker following these steps:

Betting houses define which one they think is the real probability of the event happening based on the available data and their own algorithms. Simplifying for a binary event like a coin toss we now that the probability of getting heads is 0.5, then the odd for this event is defined as 1 to 2 so if you bet 10 € and get heads you will obtain 20 €. 

Once the odd asociated with the real probability is defined, bookmakers add their own commission, which hovers around 6% in the industry. Going back to the coin example with a 6% charges the odd will be 1.88 so the payout will go down to 18.8 € and your margin from 10 € to 8.8 €.
In order to ensure their profit, bookmakers adjust odds to attract bets in the right proportion in each side, so they secure a profit regardless of the outcome of the event. This is achieved by offering odds that are higher than the actual statistical probability of the event concerned.
With this being said, it can be seen that due to de odds defining process is unlikely that the odds of two different bookmakers will be exactly the same. In order to help the bettor to take a more informed decision and place the bet with the best odd available we will develop a shiny app comparing the data from the 4 principal betting websites in Europe that will allow comparisions between odds offered.
As we just want to showcase the skills adquired during the course, and gathering the data for all sports and countries will take a lot of time, we have decided to only develop the app for football events, and in particular for the Ligue 1 team events only. So we will only work with the Ligue 1 matches of the next journée. We think that by doing this simplification the project does not lose any relevance and makes it makeable within the scope of the course.
With the following project we aim to cover the following points of the course:
Github: We are working online from Barcelona and Amsterdam.
Shiny app: the results will be showcased in a shiny app.
Web-scraping: used to collect odds data from the different websites.
Data Manipulating and presenting: when dealing with the data webscrapped data and cleaning and structuring it.
Betting websites selection
According to several online rankings consulted, the main European betting sites are the following:

WILLIAM HILL -> http://sports.williamhill.com/bet/fr-fr/betting/t/312/France+-+Ligue+1.html
BWIN -> https://sports.bwin.fr/fr/sports/search?query=Ligue%201
BETSTARS -> https://www.betstars.fr/?no_redirect=1#/soccer/competitions/2152298
UNIBET -> https://www.unibet.fr/sport/football/ligue-1
### Overview 
This project can be divided in two parts with their respective files:

Main.R - Main script that calls the different webscraping functions, cleans the data and puts it in a data frame. It standarizes all the names of the teams with the UEFA official ones, as well as standarizes the encoding.
Webscraping functions - there is one for each website, of the form websitename_events.R. Each of these files contains a function that webscrapps all the matches and odds from the target website and returns a dataframe.
scrape_final.js - javascript used to enter the websites with the headless browser PhantomJS to skip the delayed rendering of some websites. The executable of the browser(phantomjs.exe) is also in the folder and called by the script. Please note that this is part is windows only.

### WEBSCRAPPING
While during the webscrapping of the betting websites we managed to webscrappe william hill and bwin with the rvest package for R, but for unibet and betstars we keep on gathering empty data. After some research it seems that some betting websites use a javascript delayed rendering which causes some issues. Using the following tutorial from r-Bloggers (https://www.r-bloggers.com/web-scraping-javascript-rendered-sites/) we managed to resolve this by using the headless browser PhantomJS and a java script that waits for 5 seconds before scrapping the content so it has time to get load.

### CLEANING THE DATA
The data obtained from the different websites wasn't clean or structured and it' had to be tidyed up.
In that sense there where two major complications:
1. Team names where different across the websites: we solved it by downloading the UEFA official names and comparing their Leveinstein distance with the scrapped ones.
2. Some webscrapped names contained accents: to solve this we changed the encoding of the names from UTF-8 to ASCII//TRANSLIT. 

### SHINY APP
We have created a shiny application as well for ease of use.
