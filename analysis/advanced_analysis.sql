-- ============================================================
-- Netflix Originals SQL Analysis
-- ============================================================
-- Tables:
-- originals (title, genreid, imdbscore, runtime)
-- genre     (genreid, genre)
-- ============================================================


-- ============================================================
-- Q1. Average IMDb score for each genre
-- ============================================================

SELECT
    genreid,
    ROUND(AVG(imdbscore), 2) AS avg_imdb_score
FROM originals
GROUP BY genreid;


-- ============================================================
-- Q2. Genres with average IMDb score greater than 7.5
-- ============================================================

SELECT
    genreid,
    ROUND(AVG(imdbscore), 2) AS avg_imdb_score
FROM originals
GROUP BY genreid
HAVING AVG(imdbscore) > 7.5;


-- ============================================================
-- Q3. List all Netflix Originals ordered by IMDb score (highest first)
-- ============================================================

SELECT
    title,
    imdbscore
FROM originals
ORDER BY imdbscore DESC;


-- ============================================================
-- Q4. Top 10 Netflix Originals with the longest runtime
-- ============================================================

SELECT
    title,
    runtime
FROM originals
ORDER BY runtime DESC
LIMIT 10;


-- ============================================================
-- Q5. Retrieve Netflix Originals along with their genre names
-- ============================================================

SELECT
    o.title,
    g.genre
FROM originals AS o
INNER JOIN genre AS g
    ON o.genreid = g.genreid;


-- ============================================================
-- Q6. Rank Netflix Originals by IMDb score within each genre
-- ============================================================

SELECT
    title,
    imdbscore,
    genreid,
    RANK() OVER (
        PARTITION BY genreid
        ORDER BY imdbscore DESC
    ) AS genre_rank
FROM originals;


-- ============================================================
-- Q7. Netflix Originals with IMDb score higher than overall average
-- ============================================================

SELECT
    title,
    imdbscore,
    genreid
FROM originals
WHERE imdbscore > (
    SELECT AVG(imdbscore)
    FROM originals
);


-- ============================================================
-- Q8. Total number of Netflix Originals in each genre
-- ============================================================

SELECT
    genreid,
    COUNT(title) AS total_titles
FROM originals
GROUP BY genreid;


-- ============================================================
-- Q9. Genres having more than 5 titles with IMDb score above 8
-- ============================================================

SELECT
    genreid,
    COUNT(title) AS high_rated_titles
FROM originals
WHERE imdbscore > 8
GROUP BY genreid
HAVING COUNT(title) > 5;


-- ============================================================
-- Q10. Top 3 genres by average IMDb score with total title count
-- ============================================================

SELECT
    genreid,
    ROUND(AVG(imdbscore), 2) AS avg_imdb_score,
    COUNT(title) AS total_titles
FROM originals
GROUP BY genreid
ORDER BY avg_imdb_score DESC
LIMIT 3;
