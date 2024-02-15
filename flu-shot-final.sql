-- Temp table to extract only active patients
CREATE TEMP TABLE active_patients AS
SELECT DISTINCT pat.id AS patient
FROM encounters AS e
JOIN patients AS pat
  ON e.patient = pat.id
WHERE start BETWEEN '2020-01-01 00:00' AND '2022-12-31 23:59'
  AND pat.deathdate IS NULL
  AND EXTRACT(EPOCH FROM age('2022-12-31', pat.birthdate)) / 2592000 >= 6;  --calculates age into seconds, converts it into months 

-- Temp table for flu shots in 2022
CREATE TEMP TABLE flu_shot_2022 AS
SELECT patient, MIN(date) AS earliest_flu_shot_2022
FROM immunizations
WHERE code = '5302'  --code for flu shot in immunizations table
  AND date BETWEEN '2022-01-01 00:00' AND '2022-12-31 23:59'
GROUP BY patient;

-- Final select query
SELECT pat.birthdate
      ,pat.race
      ,pat.county
      ,pat.id
      ,pat.first
      ,pat.last
      ,pat.gender
      ,EXTRACT(YEAR FROM age('12-31-2022', birthdate)) AS age
      ,flu.earliest_flu_shot_2022
      ,flu.patient
      ,CASE WHEN flu.patient IS NOT NULL THEN 1 
            ELSE 0
            END AS flu_shot_2022
FROM patients AS pat
LEFT JOIN flu_shot_2022 AS flu
  ON pat.id = flu.patient
WHERE pat.id IN (SELECT patient FROM active_patients);
