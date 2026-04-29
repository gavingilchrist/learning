DROP TABLE IF EXISTS training.ELEMENTS2;
CREATE TABLE training.ELEMENTS2(
   ELEMENT VARCHAR(10),
   START_SEQ INT,
   END_SEQ INT
);

INSERT INTO training.ELEMENTS2 (ELEMENT, START_SEQ, END_SEQ)
VALUES
    ('A','1','2'),
    ('A','2','3'),
    ('A','4','5'),
    ('A','5','6'),
    ('A','6','7'),
    ('B','8','9'),
    ('B','9','10'),
    ('C','11','12');

SELECT * FROM training.ELEMENTS2;

-- The output should capture the element and the minimum and maximum of 
-- continuous sequence available for the element in the source table.
--------------------------------------------------------------------------

WITH MIN_SEQS AS 
(
    SELECT a.ELEMENT,
           a.START_SEQ,
           ROW_NUMBER() OVER (PARTITION BY ELEMENT 
                              ORDER BY START_SEQ) AS IDX
    FROM training.ELEMENTS2 a
         LEFT JOIN training.ELEMENTS2 b ON a.ELEMENT = b.ELEMENT
                                       AND a.START_SEQ = b.END_SEQ
    WHERE b.ELEMENT IS NULL
)
, MAX_SEQS AS
(
    SELECT a.ELEMENT,
           a.END_SEQ,
           ROW_NUMBER() OVER (PARTITION BY ELEMENT 
                              ORDER BY END_SEQ) AS IDX
    FROM training.ELEMENTS2 a
         LEFT JOIN training.ELEMENTS2 b ON a.ELEMENT = b.ELEMENT
                                       AND a.END_SEQ = b.START_SEQ
    WHERE b.ELEMENT IS NULL
)
SELECT a.ELEMENT,
       a.START_SEQ AS MIN_SEQ,
       b.END_SEQ AS MAX_SEQ
FROM MIN_SEQS a
     INNER JOIN MAX_SEQS b ON a.ELEMENT=b.ELEMENT
                          AND a.IDX=b.IDX;
