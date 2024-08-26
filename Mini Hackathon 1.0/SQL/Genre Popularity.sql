/*
Popular Genre in a Year, we get the most popular genre based on the ratings
*/
WITH popular AS (
	SELECT Released_Year, 
	MAX(IMDB_Rating) AS Maximum_Rating
	FROM imdb
	GROUP BY Released_Year)
    
SELECT i.Released_Year, i.Genre, i.IMDB_Rating
FROM imdb i
JOIN popular p
ON i.Released_Year = p.Released_Year
AND i.IMDB_Rating = p.Maximum_Rating
ORDER BY i.Released_Year;

/*
Genre Popularity Over the Years
*/
SELECT Released_Year, Genre, IMDB_Rating,
DENSE_RANK() OVER(
	PARTITION BY Released_Year ORDER BY IMDB_Rating DESC)
    AS IMDB_Rank
FROM imdb;