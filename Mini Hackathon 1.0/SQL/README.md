
# IMDB_Analysis

In this project, I have conducted a comprehensive analysis of the IMDB dataset, exploring various factors that contribute to a movie's success. The analysis includes examining the impact of directors on earnings, tracking the popularity of different genres over the years, assessing the influence of movie length, and investigating the correlation between ratings and commercial success. Additionally, I have identified the movie with the highest gross and analyzed the role of actors, and genre in shaping a movie's performance. This project provides valuable insights into the dynamics of the film industry, offering a data-driven perspective on what makes a movie successful.

Work Flow and Analysis: https://www.loom.com/share/21147ab0a65e4bebb96651cff4227852?sid=d5f0f6f8-002c-4515-a89f-1779a948291e

## Director's Imapct on Earnings

Here is the SQL Query that shows the impact of director's average movie rating on the gross.

```bash
SELECT Director, 
ROUND(AVG(IMDB_Rating),2) Average_Movie_Rating, SUM(Gross) Total_Gross
FROM imdb
GROUP BY Director
ORDER BY Total_Gross DESC;

-- ANALYSIS
/*
By this query we can see the average rating of movies
directed by a director along with total gross.
We can also see the relation between Average Rating and Total Gross
In most of the cases, higher the rating - higher the gross.
*/
```
This SQL query retrieves data from an `imdb` table, focusing on the performance of directors based on their movies. It calculates and displays the following for each director:

- **Average Movie Rating**: The average IMDb rating of all movies directed by the director, rounded to two decimal places.
- **Total Gross**: The sum of gross earnings from all movies directed by the director.

The results are grouped by each director and ordered by the total gross earnings in descending order, allowing us to see which directors have generated the highest box office revenue.

## Genre Popularity Over the Years
```bash
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
```
This SQL query identifies the most popular movie genre for each year based on the highest IMDb rating. It consists of two main parts:

1. **CTE `popular`**: 
   - This Common Table Expression (CTE) calculates the highest IMDb rating (`Maximum_Rating`) for each year (`Released_Year`).
   - The results are grouped by the year of release, ensuring that we get the highest-rated movie for each year.

2. **Main Query**:
   - The main query retrieves the genre, release year, and IMDb rating of the movie that had the highest IMDb rating for each year.
   - It joins the `imdb` table with the `popular` CTE on the `Released_Year` and `IMDB_Rating`, filtering out the most popular genre for each year.
   - Finally, it orders the results chronologically by the year of release.

```bash
/*
Genre Popularity Over the Years
*/
SELECT Released_Year, Genre, IMDB_Rating,
DENSE_RANK() OVER(
	PARTITION BY Released_Year ORDER BY IMDB_Rating DESC)
    AS IMDB_Rank
FROM imdb;
```
This SQL query ranks movie genres by their IMDb ratings for each release year, providing insight into genre popularity over time.

- **SELECT Released_Year, Genre, IMDB_Rating**: 
  - Retrieves the year of release, genre, and IMDb rating for each movie from the `imdb` table.
  
- **DENSE_RANK() OVER(...) AS IMDB_Rank**:
  - This function assigns a rank to each genre based on its IMDb rating within the same `Released_Year`.
  - **PARTITION BY Released_Year**: Groups the data by each release year, so the ranking restarts for every year.
  - **ORDER BY IMDB_Rating DESC**: Ranks the genres in descending order of their IMDb ratings, meaning the highest-rated genre for each year will have a rank of 1.

The result of this query shows how genres are ranked by IMDb rating each year, allowing you to track which genres were most popular in different years.

## Movie Length impact
This SQL query analyzes how the runtime of movies affects their IMDb ratings and gross earnings.
```bash
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
```
**SELECT Runtime, ROUND(AVG(IMDB_Rating),2) AS Average_Rating, AVG(Gross) AS Average_Gross**:
  - Retrieves the runtime of movies, the average IMDb rating, and the average gross earnings from the `imdb` table.
  - The `ROUND(AVG(IMDB_Rating),2)` function calculates the average IMDb rating for movies with the same runtime, rounding it to two decimal places.
  - The `AVG(Gross)` function calculates the average gross earnings for movies with the same runtime.

- **GROUP BY Runtime**:
  - Groups the data by the `Runtime` column, meaning all movies with the same runtime are aggregated together to calculate their average rating and gross earnings.

- **ORDER BY Average_Rating DESC, Average_Gross DESC**:
  - Orders the results first by average IMDb rating in descending order and then by average gross earnings in descending order. This helps in identifying the runtimes that tend to result in higher ratings and earnings.

## Correlation Between Ratings and Commercial Success
This SQL query examines the relationship between IMDb ratings and the gross earnings of movies to determine if higher-rated movies tend to generate more revenue.
```bash
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
```
- **SELECT IMDB_Rating, AVG(Gross) AS Average_Gross**:
      - Calculates the average gross earnings for each IMDb rating.
    - **GROUP BY IMDB_Rating**:
      - Groups the results by IMDb rating to calculate the average gross for movies with the same rating.
    - **ORDER BY IMDB_Rating DESC**:
      - Orders the results by IMDb rating in descending order, making it easy to observe how gross earnings vary with ratings.

## Movie with Highest Gross
```bash
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
SELECT Genre, AVG(Gross) AS AVG_Gross
FROM imdb
GROUP BY Genre
ORDER BY AVG_Gross DESC;


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
```
**`SELECT Series_Title, Genre, Director, Actors, IMDB_Rating, Gross`**:
  - Retrieves the movie's title, genre, director, actors, IMDB rating, and gross revenue.
  
- **`FROM imdb`**:
  - Specifies the `imdb` table as the data source.
  
- **`WHERE Gross = (SELECT MAX(Gross) FROM imdb)`**:
  - Filters the results to include only the movie(s) with the highest gross revenue.

## Total Movies of Star1
This set of SQL queries finds movies where an actor listed as `Star1` also appears in other roles (`Star2`, `Star3`, or `Star4`) in different movies.
```bash
/*
Finding the movies where Star1 is in other Stars column for other movies
*/

-- Finding no.of movies of Star1 as star1
SELECT Star1, COUNT(Series_Title) 'No.of_Movines'
FROM imdb
GROUP BY Star1;

```
**`SELECT Star1, COUNT(Series_Title) 'No.of_Movies'`**:
  - Retrieves each actor listed as `Star1` and counts the number of movies they are featured in as `Star1`.

- **`FROM imdb`**:
  - Specifies the `imdb` table as the data source.

- **`GROUP BY Star1`**:
  - Groups the results by `Star1` to count the number of movies for each actor.

```bash
-- Finding total no.of movies of Star1, even as Star2, Star3, or Star4 in a movie
SELECT COUNT(*) 'Total_No.of_Movies'
FROM imdb
WHERE Actors like '%Marlon Brando%';
```
**`SELECT COUNT(*) 'Total_No.of_Movies'`**:
  - Counts the total number of movies where the specified actor appears in any role.

- **`FROM imdb`**:
  - Specifies the `imdb` table as the data source.

- **`WHERE Actors like '%Marlon Brando%'`**:
  - Filters the dataset to include only those movies where "Marlon Brando" is listed in any of the star columns (`Star1`, `Star2`, `Star3`, `Star4`).

```bash
-- ANALYSIS
/*
Actors under Star1 column are also part of other movies where they are under Star2, Star3, or Star4
For example, 'Marlon Brando' is Star1 in 2 movies, and in total 'Marlon Brando' has 4 movies done,
which means 'Marlon Brando' is a Star2, or Star3, or Star4 in remaing 2 movies
*/
```

## Certificate Impact
This SQL query calculates the average gross revenue of movies based on their certification and ranks these certifications by the average gross revenue in descending order.
```bash
/*
Certified movies having highest Gross
*/

SELECT Certificate, ROUND(AVG(Gross)) Average_Gross
FROM imdb
GROUP BY Certificate
ORDER BY Average_Gross DESC;
```
**`SELECT Certificate, ROUND(AVG(Gross)) Average_Gross`**:
  - Retrieves each certification and the average gross revenue for movies with that certification.
  - The `ROUND(AVG(Gross))` function calculates the average gross revenue and rounds it to the nearest whole number.

- **`FROM imdb`**:
  - Specifies the `imdb` table as the data source.

- **`GROUP BY Certificate`**:
  - Groups the results by `Certificate` to calculate the average gross revenue for each certification category.

- **`ORDER BY Average_Gross DESC`**:
  - Orders the results by the average gross revenue in descending order, highlighting certifications associated with higher gross revenues.
```bash
-- ANALYSIS
/*
The movies with UA, U, and A certificates are having Good Gross, 
The movies with average gross range from 58645446 to 122122552
are certified as A, U, and UA
*/
```




