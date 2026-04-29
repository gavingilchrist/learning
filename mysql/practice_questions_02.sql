DROP TABLE IF EXISTS training.MATCH_RESULTS;
CREATE TABLE training.MATCH_RESULTS(
   TEAM_A VARCHAR(10),
   TEAM_B VARCHAR(10),
   RESULT VARCHAR(10)
);

INSERT INTO training.MATCH_RESULTS (TEAM_A, TEAM_B, RESULT)
VALUES
    ('India','Bangladesh','India'),
    ('India','Pakistan','India'),
    ('India','Srilanka',''),
    ('Srilanka','Bangladesh','Srilanka'),
    ('Srilanka','Pakistan','Pakistan'),
    ('Bangladesh','Pakistan','Bangladesh');

SELECT * FROM training.MATCH_RESULTS;

-- The output should contain the number of matches played, won, 
-- lost and tied for each team.
--------------------------------------------------------------------------

-- (With subquery as CTE)
WITH TEAM_RESULTS AS 
(
    SELECT TEAM_A AS TEAM,
           TEAM_B AS VS,
           RESULT
    FROM training.MATCH_RESULTS
    UNION ALL
    SELECT TEAM_B AS TEAM,
           TEAM_A AS VS,
           RESULT
    FROM training.MATCH_RESULTS
)
SELECT TEAM,
       COUNT(*) AS MATCHES_PLAYED,
       SUM(CASE WHEN RESULT=TEAM THEN 1 ELSE 0 END) AS WINS,
       SUM(CASE WHEN RESULT='' THEN 1 ELSE 0 END) AS TIES,
       SUM(CASE WHEN RESULT=VS THEN 1 ELSE 0 END) AS LOSS
FROM TEAM_RESULTS
GROUP BY TEAM;

-- (With subquery nested)
SELECT TEAM,
       COUNT(*) AS MATCHES_PLAYED,
       SUM(CASE WHEN RESULT=TEAM THEN 1 ELSE 0 END) AS WINS,
       SUM(CASE WHEN RESULT='' THEN 1 ELSE 0 END) AS TIES,
       SUM(CASE WHEN RESULT=VS THEN 1 ELSE 0 END) AS LOSS
FROM (SELECT TEAM_A AS TEAM,
             TEAM_B AS VS,
             RESULT
      FROM training.MATCH_RESULTS
      UNION ALL
      SELECT TEAM_B AS TEAM,
             TEAM_A AS VS,
             RESULT
      FROM training.MATCH_RESULTS) AS t
GROUP BY TEAM;
