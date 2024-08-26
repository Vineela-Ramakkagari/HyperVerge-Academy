/*
Finding the movies where Star1 is in other Stars column for other movies
*/

-- Finding no.of movies of Star1 as star1
SELECT Star1, COUNT(Series_Title) 'No.of_Movines'
FROM imdb
GROUP BY Star1;

-- Finding total no.of movies of Star1, even as Star2, Star3, or Star4 in a movie
SELECT COUNT(*) 'Total_No.of_Movies'
FROM imdb
WHERE Actors like '%Marlon Brando%';


-- ANALYSIS
/*
Actors under Star1 column are also part of other movies where they are under Star2, Star3, or Star4
For example, 'Marlon Brando' is Star1 in 2 movies, and in total 'Marlon Brando' has 4 movies done,
which means 'Marlon Brando' is a Star2, or Star3, or Star4 in remaing 2 movies
*/