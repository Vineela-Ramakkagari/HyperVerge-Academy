/*
Certified movies having highest Gross
*/

SELECT Certificate, ROUND(AVG(Gross)) Average_Gross
FROM imdb
GROUP BY Certificate
ORDER BY Average_Gross DESC;

-- ANALYSIS
/*
The movies with UA, U, and A certificates are having Good Gross, 
The movies with average gross range from 58645446 to 122122552
are certified as A, U, and UA
*/