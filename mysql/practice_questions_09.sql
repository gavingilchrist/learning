DROP TABLE IF EXISTS training.NUMBERS;
CREATE TABLE training.NUMBERS(
   ID INT
);

INSERT INTO training.NUMBERS (ID)
VALUES
    (1),
    (4),
    (7),
    (9),
    (12),
    (14),
    (16),
    (17),
    (20);

SELECT * FROM training.NUMBERS;

-- The output should contain the missing numbers in the series of 
-- numbers present in the source.
--------------------------------------------------------------------------

WITH RECURSIVE FULLRNG AS
(
    SELECT MIN(ID) AS ID
    FROM training.NUMBERS

    UNION ALL

    SELECT a.ID+1
    FROM FULLRNG a,
         (SELECT MAX(ID) AS MAXID 
          FROM training.NUMBERS) b 
    WHERE a.ID < b.MAXID
)
SELECT a.ID 
FROM FULLRNG a
     LEFT JOIN training.NUMBERS b ON a.ID = b.ID
WHERE b.ID IS NULL
ORDER BY b.ID;
