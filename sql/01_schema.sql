-- PostgreSQL Query Optimization
-- Step 1: schema and data load
-- Author: Odysseas Tamvakos

-- All columns are VARCHAR so the CSV import never fails on dirty values.
DROP TABLE IF EXISTS Vehicle_Information CASCADE;
CREATE TABLE Vehicle_Information (
    row_id VARCHAR(50),
    Accident_Index VARCHAR(50),
    Age_Band_of_Driver VARCHAR(50),
    Age_of_Vehicle VARCHAR(50),
    make VARCHAR(100),
    model VARCHAR(100),
    Sex_of_Driver VARCHAR(50),
    Vehicle_Type VARCHAR(50)
);

DROP TABLE IF EXISTS Accident_Information CASCADE;
CREATE TABLE Accident_Information (
    row_id VARCHAR(50),
    Accident_Index VARCHAR(50),
    "1st_Road_Class" VARCHAR(50),
    Accident_Severity VARCHAR(50),
    Date VARCHAR(20),
    Urban_or_Rural_Area VARCHAR(50),
    Weather_Conditions VARCHAR(100),
    Year VARCHAR(20),
    InScotland VARCHAR(20)
);

-- Load the data (run from psql; the CSVs are not included in this repository).
-- The CSVs must contain exactly the columns above, in the same order.
-- \copy Accident_Information FROM 'data/Accident_Information.csv' WITH (FORMAT csv, HEADER true)
-- \copy Vehicle_Information  FROM 'data/Vehicle_Information.csv'  WITH (FORMAT csv, HEADER true)
