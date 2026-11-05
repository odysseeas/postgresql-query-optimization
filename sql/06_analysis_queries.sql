-- Step 6: analysis queries and execution plans

-- Accidents per road class
SELECT "1st_Road_Class", COUNT(*)
FROM Accident_Information
GROUP BY "1st_Road_Class";

-- Accidents per road class and severity
SELECT "1st_Road_Class", Accident_Severity, COUNT(*)
FROM Accident_Information
GROUP BY "1st_Road_Class", Accident_Severity;

-- Main benchmark query (steps 1-4 in the README):
-- urban accidents before 2010 involving drivers aged 26-35
EXPLAIN ANALYZE
SELECT COUNT(*)
FROM Accident_Information A
JOIN Vehicle_Information V ON A.Accident_Index = V.Accident_Index
WHERE A.Urban_or_Rural_Area = 'Urban'
  AND A.Date < '2010-01-01'
  AND V.Age_Band_of_Driver = '26 - 35';

-- Partition pruning check (after 05_partitioning.sql):
-- rural accidents in 2010 involving drivers aged 26-35
EXPLAIN ANALYZE
SELECT COUNT(*)
FROM Accident_Information A
JOIN Vehicle_Information V ON A.Accident_Index = V.Accident_Index
WHERE A.Urban_or_Rural_Area = 'Rural'
  AND A.Year = '2010'
  AND V.Age_Band_of_Driver = '26 - 35';

-- Most common vehicle make among drivers aged 26-35, 2010-2012
SELECT V.make, COUNT(*)
FROM Accident_Information A
JOIN Vehicle_Information V ON A.Accident_Index = V.Accident_Index
WHERE (A.Year BETWEEN '2010' AND '2012')
  AND V.Age_Band_of_Driver = '26 - 35'
GROUP BY V.make
ORDER BY COUNT(*) DESC
LIMIT 1;
