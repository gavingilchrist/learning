DROP TABLE IF EXISTS training.STUDENTS;
CREATE TABLE training.STUDENTS(
   ID INT,
   NAME varchar(10),
   SUBJECT varchar(10),
   SCORE INT
);

INSERT INTO training.STUDENTS (ID, NAME, SUBJECT, SCORE)
VALUES
   ('1','Ram','Maths','50'),
   ('1','Ram','Physics','65'),
   ('1','Ram','Chemistry','70'),
   ('2','Neena','Maths','88'),
   ('2','Neena','Physics','90'),
   ('2','Neena','Chemistry','65'),
   ('3','John','Maths','100'),
   ('3','John','Physics','45'),
   ('3','John','Chemistry','52');

SELECT * FROM training.STUDENTS;

-- The output should Denormalize the data converting the rows into columns 
-- creating a single record for each student showing marks scored in all 
-- subjects.
--------------------------------------------------------------------------

-- Using CASE WHEN 
SELECT ID,
       NAME,
       SUM(CASE WHEN SUBJECT='Maths' THEN SCORE ELSE 0 END) AS MATHS,
       SUM(CASE WHEN SUBJECT='Physics' THEN SCORE ELSE 0 END) AS PHYSICS,
       SUM(CASE WHEN SUBJECT='Chemistry' THEN SCORE ELSE 0 END) AS CHEMISTRY
FROM training.STUDENTS
GROUP BY ID, NAME;

-- Using PIVOT - but not using MySQL
--SELECT *
--FROM training.STUDENTS
--PIVOT (SUM(SCORE) FOR SUBJECT IN ('Maths' AS MATHS,
--                                  'Physics' AS PHYSICS,
--                                  'Chemistry' AS CHEMISTRY));
