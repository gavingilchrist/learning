DROP TABLE IF EXISTS training.BALANCES;
CREATE TABLE training.BALANCES(
   BALANCE DOUBLE,
   DATES DATE
);

INSERT INTO training.BALANCES (BALANCE, DATES)
VALUES
    ('26000','2020-01-01'),
    ('26000','2020-01-02'),
    ('26000','2020-01-03'),
    ('30000','2020-01-04'),
    ('30000','2020-01-05'),
    ('26000','2020-01-06'),
    ('26000','2020-01-07'),
    ('32000','2020-01-08'),
    ('31000','2020-01-09');

SELECT * FROM training.BALANCES;

-- The output should capture the start and end dates where the balance 
-- amount remains constant continuously days.
--------------------------------------------------------------------------

-- Using cumulative count of change flag
WITH NEWBAL_FL AS
(
SELECT BALANCE,
       DATES,
       BALANCE != (LAG(BALANCE,1,-1) OVER (ORDER BY DATES)) AS NEWBAL
FROM training.BALANCES
), ADD_BAL_ID AS 
(
SELECT BALANCE,
       DATES,
       SUM(NEWBAL) OVER (ORDER BY DATES) AS BAL_ID
FROM NEWBAL_FL
)
SELECT BALANCE,
       MIN(DATES) AS START_DATE,
       MAX(DATES) AS END_DATE
FROM ADD_BAL_ID
GROUP BY BAL_ID, BALANCE;

-- Using subtraction of row IDs
WITH GPS AS
(
    SELECT *,
           (ROW_NUMBER() OVER (ORDER BY DATES))
           - (ROW_NUMBER() OVER (PARTITION BY BALANCE
                                 ORDER BY DATES)) AS GPID
    FROM training.BALANCES
)
SELECT BALANCE,
       MIN(DATES) AS START_DATE,
       MAX(DATES) AS END_DATE
FROM GPS
GROUP BY GPID, BALANCE
ORDER BY MIN(DATES);
