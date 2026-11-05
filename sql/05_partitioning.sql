-- Step 5: range partitioning of Accident_Information by Year

ALTER TABLE Accident_Information RENAME TO Accident_Information_Old;

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
) PARTITION BY RANGE (Year);

CREATE TABLE acc_2005_2008 PARTITION OF Accident_Information FOR VALUES FROM ('2005') TO ('2009');
CREATE TABLE acc_2009_2012 PARTITION OF Accident_Information FOR VALUES FROM ('2009') TO ('2013');
CREATE TABLE acc_2013_2017 PARTITION OF Accident_Information FOR VALUES FROM ('2013') TO ('2018');
CREATE TABLE acc_others    PARTITION OF Accident_Information DEFAULT;

INSERT INTO Accident_Information SELECT * FROM Accident_Information_Old;

CREATE INDEX idx_part_year_05_08 ON acc_2005_2008(Year);
CREATE INDEX idx_part_year_09_12 ON acc_2009_2012(Year);
CREATE INDEX idx_part_year_13_17 ON acc_2013_2017(Year);
