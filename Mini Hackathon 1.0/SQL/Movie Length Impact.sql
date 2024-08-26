/*
Impact of Movie Length on Ratings and Earnings
*/

SELECT Runtime, 
ROUND(AVG(IMDB_Rating),2) Average_Rating, 
AVG(Gross) Average_Gross
FROM imdb
GROUP BY Runtime
ORDER BY Average_Rating DESC, Average_Gross DESC;

-- ANALYSIS
/*
We can observe that most of the medium length movies like 145 to 195
are having good ratings with good gross.
The lower length and higher length movies are either having less rating or less gross.
*/