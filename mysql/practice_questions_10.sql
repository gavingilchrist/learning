DROP TABLE IF EXISTS training.ORDER_DETAILS;
CREATE TABLE training.ORDER_DETAILS(
   ORDER_DATE DATE, 
   ORDERS INT
);

INSERT INTO training.ORDER_DETAILS (ORDER_DATE, ORDERS)
VALUES
    ('2021-01-01',2),
    ('2021-02-01',1),
    ('2021-03-01',3),
    ('2021-04-01',4);

SELECT * FROM training.ORDER_DETAILS;

-- The requirement is to explode the order_date entries in an incremental 
-- order based on the number of orders on that day.
--------------------------------------------------------------------------

WITH RECURSIVE EXPL AS
(
    SELECT ORDER_DATE,
           ORDERS-1 AS IDX
    FROM training.ORDER_DETAILS

    UNION ALL

    SELECT ORDER_DATE,
           IDX-1 AS IDX
    FROM EXPL 
    WHERE IDX > 0
)
SELECT ORDER_DATE+IDX AS ORDER_DATE
FROM EXPL
ORDER BY ORDER_DATE;

