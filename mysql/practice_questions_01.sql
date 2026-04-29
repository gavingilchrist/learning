DROP TABLE IF EXISTS training.TEAMS;
CREATE TABLE training.TEAMS(
   COUNTRY VARCHAR(50)
);

INSERT INTO training.TEAMS (COUNTRY)
VALUES
    ('India'),
    ('Srilanka'),
    ('Bangladesh'),
    ('Pakistan');

SELECT * FROM training.TEAMS;

-- The output should provide the possible match fixtures between 
-- all the teams participating in Asia cup.
--------------------------------------------------------------------------

SELECT a.COUNTRY AS TEAM_A,
       b.COUNTRY AS TEAM_B
FROM training.TEAMS a, training.TEAMS b
WHERE a.COUNTRY < b.COUNTRY;
