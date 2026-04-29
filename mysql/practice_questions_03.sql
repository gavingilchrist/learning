DROP TABLE IF EXISTS training.ELEMENTS;
CREATE TABLE training.ELEMENTS(
   ELEMENT VARCHAR(10),
   SEQUENCE INT
);

INSERT INTO training.ELEMENTS (ELEMENT, SEQUENCE)
VALUES
    ('A','1'),
    ('A','2'),
    ('A','3'),
    ('A','5'),
    ('A','6'),
    ('A','8'),
    ('A','9'),
    ('B','11'),
    ('C','13'),
    ('C','14'),
    ('C','15');

SELECT * FROM training.ELEMENTS;

-- The output should capture the element and the minimum and maximum of 
-- continuous sequence available for the element in the source table.
--------------------------------------------------------------------------

WITH EL_GPS AS
(
SELECT *,
       SEQUENCE 
       - (ROW_NUMBER() OVER (PARTITION BY ELEMENT 
                             ORDER BY SEQUENCE)) AS GP
FROM training.ELEMENTS
)
SELECT ELEMENT,
       MIN(SEQUENCE) AS MIN_SEQ,
       MAX(SEQUENCE) AS MAX_SEQ
FROM EL_GPS
GROUP BY ELEMENT, GP;
