-- Step 2: indexes on the join key and the most common filter columns

CREATE INDEX IF NOT EXISTS idx_acc_index    ON Accident_Information(Accident_Index);
CREATE INDEX IF NOT EXISTS idx_acc_date     ON Accident_Information(Date);
CREATE INDEX IF NOT EXISTS idx_acc_year     ON Accident_Information(Year);
CREATE INDEX IF NOT EXISTS idx_acc_road     ON Accident_Information("1st_Road_Class");
CREATE INDEX IF NOT EXISTS idx_acc_area     ON Accident_Information(Urban_or_Rural_Area);
CREATE INDEX IF NOT EXISTS idx_acc_severity ON Accident_Information(Accident_Severity);

CREATE INDEX IF NOT EXISTS idx_veh_index ON Vehicle_Information(Accident_Index);
CREATE INDEX IF NOT EXISTS idx_veh_age   ON Vehicle_Information(Age_Band_of_Driver);
CREATE INDEX IF NOT EXISTS idx_veh_make  ON Vehicle_Information(make);
