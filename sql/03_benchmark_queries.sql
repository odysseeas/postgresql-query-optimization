-- Step 3: benchmark workload
-- Join + aggregation queries run before and after creating the indexes
-- (02_indexes.sql) to measure their effect.

SELECT COUNT(*) FROM Accident_Information A JOIN Vehicle_Information V ON A.Accident_Index = V.Accident_Index WHERE A.Urban_or_Rural_Area = 'Rural' AND A.Year = '2009' AND V.Age_Band_of_Driver = '26 - 35';
SELECT COUNT(*) FROM Accident_Information A JOIN Vehicle_Information V ON A.Accident_Index = V.Accident_Index WHERE A.Urban_or_Rural_Area = 'Rural' AND A.Year = '2010' AND V.Age_Band_of_Driver = '26 - 35';
SELECT COUNT(*) FROM Accident_Information A JOIN Vehicle_Information V ON A.Accident_Index = V.Accident_Index WHERE A.Urban_or_Rural_Area = 'Rural' AND A.Year = '2011' AND V.Age_Band_of_Driver = '26 - 35';
SELECT COUNT(*) FROM Accident_Information A JOIN Vehicle_Information V ON A.Accident_Index = V.Accident_Index WHERE A.Urban_or_Rural_Area = 'Rural' AND A.Year = '2012' AND V.Age_Band_of_Driver = '26 - 35';
SELECT COUNT(*) FROM Accident_Information A JOIN Vehicle_Information V ON A.Accident_Index = V.Accident_Index WHERE A.Urban_or_Rural_Area = 'Rural' AND A.Year = '2010' AND V.Age_Band_of_Driver = '17 - 20';
SELECT COUNT(*) FROM Accident_Information A JOIN Vehicle_Information V ON A.Accident_Index = V.Accident_Index WHERE A.Urban_or_Rural_Area = 'Rural' AND A.Year = '2010' AND V.Age_Band_of_Driver = '36 - 45';
SELECT COUNT(*) FROM Accident_Information A JOIN Vehicle_Information V ON A.Accident_Index = V.Accident_Index WHERE A.Urban_or_Rural_Area = 'Rural' AND A.Year = '2010' AND V.Age_Band_of_Driver = '46 - 55';
SELECT COUNT(*) FROM Accident_Information A JOIN Vehicle_Information V ON A.Accident_Index = V.Accident_Index WHERE A.Urban_or_Rural_Area = 'Urban' AND A.Year = '2010' AND V.Age_Band_of_Driver = '26 - 35';
SELECT COUNT(*) FROM Accident_Information A JOIN Vehicle_Information V ON A.Accident_Index = V.Accident_Index WHERE A.Urban_or_Rural_Area = 'Urban' AND A.Year = '2011' AND V.Age_Band_of_Driver = '26 - 35';
SELECT COUNT(*) FROM Accident_Information A JOIN Vehicle_Information V ON A.Accident_Index = V.Accident_Index WHERE A.Urban_or_Rural_Area = 'Urban' AND A.Year = '2012' AND V.Age_Band_of_Driver = '26 - 35';
