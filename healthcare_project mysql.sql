CREATE DATABASE healthcare_analytics;
CREATE TABLE healthcare_data (
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(20),
    Blood_Type VARCHAR(10),
    Medical_Condition VARCHAR(50),
    Date_of_Admission DATE,
    Doctor VARCHAR(100),
    Hospital VARCHAR(150),
    Insurance_Provider VARCHAR(50),
    Billing_Amount DECIMAL(10,2),
    Room_Number INT,
    Admission_Type VARCHAR(30),
    Discharge_Date DATE,
    Medication VARCHAR(100),
    Test_Results VARCHAR(50),
    Length_of_Stay INT
);
SHOW DATABASES;
USE healthcare_analytics;
SHOW TABLES;
SELECT COUNT(*) AS total_rows
FROM healthcare_data;
SELECT * FROM healthcare_data LIMIT 10;
DESCRIBE healthcare_data;
SELECT
    COUNT(*) AS Total_Rows,
    SUM(Name IS NULL) AS Missing_Name,
    SUM(Age IS NULL) AS Missing_Age,
    SUM(Gender IS NULL) AS Missing_Gender,
    SUM(Medical_Condition IS NULL) AS Missing_Condition,
    SUM(Date_of_Admission IS NULL) AS Missing_Admission_Date,
    SUM(Billing_Amount IS NULL) AS Missing_Billing,
    SUM(Discharge_Date IS NULL) AS Missing_Discharge_Date,
    SUM(Length_of_Stay IS NULL) AS Missing_Length_of_Stay
FROM healthcare_data;


SELECT
    MIN(Date_of_Admission) AS first_admission,
    MAX(Date_of_Admission) AS last_admission,
    MIN(Discharge_Date) AS first_discharge,
    MAX(Discharge_Date) AS last_discharge
FROM healthcare_data;


SELECT
    Discharge_Date,
    COUNT(*) AS total
FROM healthcare_data
GROUP BY Discharge_Date
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    COUNT(Discharge_Date) AS discharge_dates,
    SUM(Discharge_Date IS NULL) AS null_discharge_dates
FROM healthcare_data ;

SELECT
    MIN(Age) AS min_age,
    MAX(Age) AS max_age,
    MIN(Billing_Amount) AS min_bill,
    MAX(Billing_Amount) AS max_bill,
    MIN(Length_of_Stay) AS min_stay,
    MAX(Length_of_Stay) AS max_stay
FROM healthcare_data;

SELECT
    COUNT(*) AS negative_billing_records
FROM healthcare_data
WHERE Billing_Amount < 0;

SELECT
    MIN(Length_of_Stay) AS min_stay,
    MAX(Length_of_Stay) AS max_stay,
    COUNT(Length_of_Stay) AS stay_records,
    SUM(Length_of_Stay IS NULL) AS null_stay
FROM healthcare_data;


SELECT
    Date_of_Admission,
    Discharge_Date,
    DATEDIFF(Discharge_Date, Date_of_Admission) AS Calculated_Stay
FROM healthcare_data
LIMIT 10;


set sql_safe_updates = 0;

UPDATE healthcare_data
SET Length_of_Stay = DATEDIFF(Discharge_Date, Date_of_Admission);

SELECT
    MIN(Length_of_Stay) AS min_stay,
    MAX(Length_of_Stay) AS max_stay,
    AVG(Length_of_Stay) AS avg_stay
FROM healthcare_data;

SELECT
    Name,
    Medical_Condition,
    Billing_Amount,
    Insurance_Provider,
    Admission_Type
FROM healthcare_data
WHERE Billing_Amount < 0
LIMIT 20;

SELECT
    COUNT(*) AS negative_records,
    SUM(Billing_Amount) AS negative_total
FROM healthcare_data
WHERE Billing_Amount < 0;

UPDATE healthcare_data
SET Billing_Amount = ABS(Billing_Amount)
WHERE Billing_Amount < 0;

SELECT
    COUNT(*) AS negative_records,
    MIN(Billing_Amount) AS minimum_bill
FROM healthcare_data
WHERE Billing_Amount < 0;

SELECT
    Name,
    Age,
    Gender,
    Date_of_Admission,
    Hospital,
    Billing_Amount,
    COUNT(*) AS duplicate_count
FROM healthcare_data
GROUP BY
    Name,
    Age,
    Gender,
    Date_of_Admission,
    Hospital,
    Billing_Amount
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS duplicate_groups
FROM (
    SELECT
        Name,
        Age,
        Gender,
        Date_of_Admission,
        Hospital,
        Billing_Amount
    FROM healthcare_data
    GROUP BY
        Name,
        Age,
        Gender,
        Date_of_Admission,
        Hospital,
        Billing_Amount
    HAVING COUNT(*) > 1
) AS duplicates;

SELECT COUNT(*) AS exact_duplicate_groups
FROM (
    SELECT
        Name,
        Age,
        Gender,
        Blood_Type,
        Medical_Condition,
        Date_of_Admission,
        Doctor,
        Hospital,
        Insurance_Provider,
        Billing_Amount,
        Room_Number,
        Admission_Type,
        Discharge_Date,
        Medication,
        Test_Results,
        Length_of_Stay,
        COUNT(*) AS cnt
    FROM healthcare_data
    GROUP BY
        Name,
        Age,
        Gender,
        Blood_Type,
        Medical_Condition,
        Date_of_Admission,
        Doctor,
        Hospital,
        Insurance_Provider,
        Billing_Amount,
        Room_Number,
        Admission_Type,
        Discharge_Date,
        Medication,
        Test_Results,
        Length_of_Stay
    HAVING COUNT(*) > 1
) AS d;

SELECT 
    SUM(cnt - 1) AS duplicate_rows
FROM (
    SELECT 
        Name,
        Age,
        Gender,
        Blood_Type,
        Medical_Condition,
        Date_of_Admission,
        Doctor,
        Hospital,
        Insurance_Provider,
        Billing_Amount,
        Room_Number,
        Admission_Type,
        Discharge_Date,
        Medication,
        Test_Results,
        Length_of_Stay,
        COUNT(*) AS cnt
    FROM healthcare_data
    GROUP BY
        Name,
        Age,
        Gender,
        Blood_Type,
        Medical_Condition,
        Date_of_Admission,
        Doctor,
        Hospital,
        Insurance_Provider,
        Billing_Amount,
        Room_Number,
        Admission_Type,
        Discharge_Date,
        Medication,
        Test_Results,
        Length_of_Stay
    HAVING COUNT(*) > 1
) AS d;

CREATE TABLE healthcare_data_backup AS
SELECT * FROM healthcare_data;

CREATE TABLE healthcare_data_clean AS
SELECT DISTINCT *
FROM healthcare_data;

SELECT COUNT(*) AS cleaned_rows
FROM healthcare_data_clean;

DROP TABLE healthcare_data;

RENAME TABLE healthcare_data_clean TO healthcare_data;

SELECT COUNT(*) AS total_rows
FROM healthcare_data;

SELECT COUNT(*) AS invalid_dates
FROM healthcare_data
WHERE Discharge_Date < Date_of_Admission;

SELECT COUNT(*) AS invalid_stay
FROM healthcare_data
WHERE Length_of_Stay <= 0;

SELECT DISTINCT Gender
FROM healthcare_data;

SELECT DISTINCT Blood_Type
FROM healthcare_data;

SELECT DISTINCT Medical_Condition
FROM healthcare_data;

SELECT DISTINCT Insurance_Provider
FROM healthcare_data;

SELECT DISTINCT Admission_Type
FROM healthcare_data;

SELECT DISTINCT Test_Results
FROM healthcare_data;

SELECT COUNT(*) AS Total_Admissions
FROM healthcare_data;

SELECT
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing
FROM healthcare_data;

SELECT
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing
FROM healthcare_data;

SELECT
    ROUND(AVG(Length_of_Stay), 2) AS Average_Length_of_Stay
FROM healthcare_data;

SELECT
    MAX(Length_of_Stay) AS Maximum_Length_of_Stay
FROM healthcare_data;

SELECT
    MIN(Length_of_Stay) AS Minimum_Length_of_Stay
FROM healthcare_data;

SELECT
    Medical_Condition,
    COUNT(*) AS Total_Admissions
FROM healthcare_data
GROUP BY Medical_Condition
ORDER BY Total_Admissions DESC;

SELECT
    Medical_Condition,
    COUNT(*) AS Total_Admissions,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing,
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing
FROM healthcare_data
GROUP BY Medical_Condition
ORDER BY Total_Billing DESC;


SELECT
    Admission_Type,
    COUNT(*) AS Total_Admissions,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing,
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing
FROM healthcare_data
GROUP BY Admission_Type
ORDER BY Total_Admissions DESC;

SELECT
    Insurance_Provider,
    COUNT(*) AS Total_Admissions,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing,
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing
FROM healthcare_data
GROUP BY Insurance_Provider
ORDER BY Total_Billing DESC;

SELECT
    Hospital,
    COUNT(*) AS Total_Admissions,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing,
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing,
    ROUND(AVG(Length_of_Stay), 2) AS Average_Stay
FROM healthcare_data
GROUP BY Hospital
ORDER BY Total_Billing DESC
LIMIT 10;

SELECT
    YEAR(Date_of_Admission) AS Admission_Year,
    COUNT(*) AS Total_Admissions,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing
FROM healthcare_data
GROUP BY YEAR(Date_of_Admission)
ORDER BY Admission_Year;


SELECT
    CASE
        WHEN Age < 18 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 30 THEN '18-30'
        WHEN Age BETWEEN 31 AND 45 THEN '31-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '61+'
    END AS Age_Group,
    COUNT(*) AS Total_Admissions,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing,
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing
FROM healthcare_data
GROUP BY Age_Group
ORDER BY Total_Admissions DESC;

SELECT
    Test_Results,
    COUNT(*) AS Total_Admissions,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing,
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing,
    ROUND(AVG(Length_of_Stay), 2) AS Average_Stay
FROM healthcare_data
GROUP BY Test_Results
ORDER BY Total_Admissions DESC;

SELECT
    Medication,
    COUNT(*) AS Total_Admissions,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing,
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing,
    ROUND(AVG(Length_of_Stay), 2) AS Average_Stay
FROM healthcare_data
GROUP BY Medication
ORDER BY Total_Admissions DESC;

SELECT
    Doctor,
    COUNT(*) AS Total_Admissions,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing,
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing,
    ROUND(AVG(Length_of_Stay), 2) AS Average_Stay
FROM healthcare_data
GROUP BY Doctor
ORDER BY Total_Admissions DESC
LIMIT 10;

SELECT
    CASE
        WHEN Billing_Amount < 10000 THEN 'Low Billing'
        WHEN Billing_Amount BETWEEN 10000 AND 30000 THEN 'Medium Billing'
        ELSE 'High Billing'
    END AS Billing_Category,
    COUNT(*) AS Total_Admissions,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing,
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing
FROM healthcare_data
GROUP BY Billing_Category
ORDER BY Total_Admissions DESC;

SELECT
    Medical_Condition,
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing
FROM healthcare_data
GROUP BY Medical_Condition
HAVING AVG(Billing_Amount) > (
    SELECT AVG(Billing_Amount)
    FROM healthcare_data
)
ORDER BY Average_Billing DESC;

WITH Condition_Analysis AS (
    SELECT
        Medical_Condition,
        COUNT(*) AS Total_Admissions,
        ROUND(AVG(Billing_Amount), 2) AS Average_Billing,
        ROUND(AVG(Length_of_Stay), 2) AS Average_Stay
    FROM healthcare_data
    GROUP BY Medical_Condition
)
SELECT
    Medical_Condition,
    Total_Admissions,
    Average_Billing,
    Average_Stay
FROM Condition_Analysis
ORDER BY Average_Billing DESC;

WITH Condition_Billing AS (
    SELECT
        Medical_Condition,
        COUNT(*) AS Total_Admissions,
        ROUND(SUM(Billing_Amount), 2) AS Total_Billing
    FROM healthcare_data
    GROUP BY Medical_Condition
)
SELECT
    Medical_Condition,
    Total_Admissions,
    Total_Billing,
    RANK() OVER (ORDER BY Total_Billing DESC) AS Billing_Rank
FROM Condition_Billing
ORDER BY Billing_Rank;

WITH Hospital_Billing AS (
    SELECT
        Hospital,
        COUNT(*) AS Total_Admissions,
        ROUND(SUM(Billing_Amount), 2) AS Total_Billing
    FROM healthcare_data
    GROUP BY Hospital
)
SELECT
    Hospital,
    Total_Admissions,
    Total_Billing,
    ROW_NUMBER() OVER (ORDER BY Total_Billing DESC) AS Billing_Row_Number
FROM Hospital_Billing
ORDER BY Billing_Row_Number
LIMIT 10;

SELECT
    Medical_Condition,
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing,

    RANK() OVER (
        ORDER BY AVG(Billing_Amount) DESC
    ) AS Billing_Rank,

    DENSE_RANK() OVER (
        ORDER BY AVG(Billing_Amount) DESC
    ) AS Dense_Billing_Rank,

    ROW_NUMBER() OVER (
        ORDER BY AVG(Billing_Amount) DESC
    ) AS Billing_Row_Number

FROM healthcare_data
GROUP BY Medical_Condition
ORDER BY Billing_Rank;

CREATE OR REPLACE VIEW healthcare_kpi_summary AS
SELECT
    COUNT(*) AS Total_Admissions,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing,
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing,
    ROUND(AVG(Length_of_Stay), 2) AS Average_Length_of_Stay,
    MIN(Length_of_Stay) AS Minimum_Length_of_Stay,
    MAX(Length_of_Stay) AS Maximum_Length_of_Stay
FROM healthcare_data;

SELECT *
FROM healthcare_kpi_summary;
