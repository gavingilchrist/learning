DROP TABLE IF EXISTS training.STUDENT_MARKS;
CREATE TABLE training.STUDENT_MARKS(
   STUDENT_NAME VARCHAR(50),
   TOTAL_MARKS INT,
   YEAR INT(4)
);

INSERT INTO training.STUDENT_MARKS (STUDENT_NAME, TOTAL_MARKS, YEAR)
VALUES
   ('Ram','90','2010'), 
   ('Neena','80','2010'), 
   ('John','70','2010'), 
   ('Ram','90','2011'), 
   ('Neena','85','2011'), 
   ('John','65','2011'), 
   ('Ram','80','2012'), 
   ('Neena','80','2012'), 
   ('John','90','2012');

SELECT * FROM training.STUDENT_MARKS;

-- The output should contain the details of students who scored greater 
-- than or equal to previous year.
--------------------------------------------------------------------------

WITH YOY AS 
(
SELECT STUDENT_NAME, 
       TOTAL_MARKS,
       YEAR,
       LAG(TOTAL_MARKS, 1, NULL) OVER (PARTITION BY STUDENT_NAME
                                       ORDER BY YEAR) AS PREV_YEAR_MARKS
FROM training.STUDENT_MARKS
)
SELECT *
FROM YOY
WHERE TOTAL_MARKS >= PREV_YEAR_MARKS;
