/*
Correlation between IMDB_Ratings and Commercial Success
*/
SELECT Series_Title, IMDB_Rating, Gross
FROM imdb
WHERE Gross != -1
ORDER BY IMDB_Rating DESC;

SELECT IMDB_Rating, AVG(Gross) Average_Gross
FROM imdb
GROUP BY IMDB_Rating
ORDER BY IMDB_Rating DESC;

-- ANALYSIS
/*
We can see a trend of the commercial success based on the ratings,
The range of higher ratings like 8.7 to 9.2 have higher gross range from 13000000 to 200000000,
and smaller ratings range like 7.6 to 8.3 have gross range from 40000000 to 62000000
We can say that in most of the cases, higher the rating, higher the gross earnings
*/

