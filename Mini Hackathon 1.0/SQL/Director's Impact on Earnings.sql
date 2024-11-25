CREATE DATABASE hackathon;

USE hackathon;

SELECT * FROM imdb;

/*
Director's Impact on Gross Earnings
*/
SELECT Director, 
ROUND(AVG(IMDB_Rating),2) Average_Movie_Rating, AVG(Gross) Average_Gross
FROM imdb
GROUP BY Director
ORDER BY Average_Gross DESC;

-- ANALYSIS
/*
By this query we can see the average rating of movies
directed by a director along with total gross.
We can also see the relation between Average Rating and Total Gross
In most of the cases, higher the rating - higher the gross.
*/






