/*
Which movie has the highest gross, and analyse why it got the highest
*/

-- Finding the Movie which has the Highest Gross
SELECT Series_Title, Genre, Director,
Actors, IMDB_Rating, Gross
FROM imdb
WHERE Gross = (SELECT MAX(Gross) FROM imdb);


-- Finding which Genre is liked by people most
SELECT Genre, ROUND(AVG(IMDB_Rating),2) Average_Rating
FROM imdb
GROUP BY Genre
ORDER BY AVG(IMDB_Rating) DESC;


-- Finding the Genre which has highest Gross
SELECT Genre, SUM(Gross) Total_Gross
FROM imdb
GROUP BY Genre
ORDER BY Total_Gross DESC;


-- To observe the effect of Star1 on the movie
SELECT Star1, AVG(Gross)
FROM imdb
GROUP BY Star1
ORDER BY AVG(Gross) DESC;


-- To observe the effect of Star2 on the movie
SELECT Star2, AVG(Gross)
FROM imdb
GROUP BY Star2
ORDER BY AVG(Gross) DESC;


-- To observe the effect of Star3 on the movie
SELECT Star3, AVG(Gross)
FROM imdb
GROUP BY Star3
ORDER BY AVG(Gross) DESC;


-- To observe the effect of Star4 on the movie
SELECT Star4, AVG(Gross)
FROM imdb
GROUP BY Star4
ORDER BY AVG(Gross) DESC;


-- Director Analysis
SELECT Director, 
ROUND(AVG(IMDB_Rating),2) Average_Rating, SUM(Gross) Total_Gross
FROM imdb
GROUP BY Director
ORDER BY Total_Gross DESC;

-- ANALYSIS
/*
People like the genres Action, Sci-Fi, they are also part of the 'Star Wars: Episode VII - The Force Awakens' movie
The Stars 1 and 2 have more Influence on the movie
Even though the overall rating of the movie, and the director are low, 
the actors, and the movie genre influenced more for the highest gross.
*/

