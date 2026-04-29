DROP TABLE IF EXISTS training.SALES;
CREATE TABLE training.SALES(
   SALES_DATE DATE,
   SALES_AMOUNT INT,
   CURRENCY VARCHAR(10)
);

INSERT INTO training.SALES (SALES_DATE, SALES_AMOUNT, CURRENCY)
VALUES
    ('2021-01-01','500','INR'),
    ('2021-01-01','100','GBP'),
    ('2021-01-02','1000','INR'),
    ('2021-01-02','500','GBP'),
    ('2021-01-03','500','INR'),
    ('2021-01-17','200','GBP');

SELECT * FROM training.SALES;

DROP TABLE IF EXISTS training.EXCHANGE_RATES;
CREATE TABLE training.EXCHANGE_RATES(
   FROM_CURRENCY VARCHAR(10),
   TO_CURRENCY VARCHAR(10),
   EXCHANGE_RATE DECIMAL(10,4),
   EFFECTIVE_START_DATE DATE
);

INSERT INTO training.EXCHANGE_RATES (FROM_CURRENCY,
                                     TO_CURRENCY,
                                     EXCHANGE_RATE,
                                     EFFECTIVE_START_DATE)
VALUES 
    ('INR','USD','0.014','2020-12-31'),
    ('INR','USD','0.015','2021-01-02'),
    ('GBP','USD','1.32','2020-12-20'),
    ('GBP','USD','1.30','2021-01-01'),
    ('GBP','USD','1.35','2021-01-16');

SELECT * FROM training.EXCHANGE_RATES;

-- The output should contain the total sales amount on day in USD.
--------------------------------------------------------------------------

WITH ER_RNG AS
(
SELECT a.FROM_CURRENCY,
       a.TO_CURRENCY,
       a.EFFECTIVE_START_DATE AS EFFECTIVE_FROM,
       MIN(b.EFFECTIVE_START_DATE) AS EFFECTIVE_BEFORE,
       MAX(a.EXCHANGE_RATE) AS EXCHANGE_RATE
FROM training.EXCHANGE_RATES a
     LEFT JOIN training.EXCHANGE_RATES b ON a.FROM_CURRENCY=b.FROM_CURRENCY
                                        AND a.TO_CURRENCY=b.TO_CURRENCY
                                        AND a.EFFECTIVE_START_DATE < b.EFFECTIVE_START_DATE
GROUP BY a.FROM_CURRENCY,
         a.TO_CURRENCY,
         a.EFFECTIVE_START_DATE
)
SELECT a.SALES_DATE,
       SUM(a.SALES_AMOUNT * b.EXCHANGE_RATE) AS TOTAL_SALES_USD
FROM training.SALES a
     INNER JOIN ER_RNG b ON a.CURRENCY=b.FROM_CURRENCY
                        AND b.EFFECTIVE_FROM <= a.SALES_DATE
                        AND (b.EFFECTIVE_BEFORE IS NULL
                             OR b.EFFECTIVE_BEFORE > a.SALES_DATE)
WHERE b.TO_CURRENCY = 'USD'
GROUP BY a.SALES_DATE;
