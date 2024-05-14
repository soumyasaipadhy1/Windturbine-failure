create database project;
use project;
SELECT * FROM project.wind_turbine;
SELECT COUNT(*) AS total_rows
FROM wind_turbine;

-- 1st moment business decision - Descriptive Statistics  -- Mean value calculate
SELECT
    AVG(Wind_speed) AS mean_Wind_speed,
    AVG(Power) AS mean_Power,
    AVG(Nacelle_ambient_temperature) AS mean_Nacelle_ambient_temperature,
    AVG(Generator_bearing_temperature) AS mean_Generator_bearing_temperature,
    AVG(Gear_oil_temperature) AS mean_Gear_oil_temperature,
    AVG(Ambient_temperature) AS mean_Ambient_temperature,
    AVG(Rotor_Speed) AS mean_Rotor_Speed,
    AVG(Nacelle_temperature) AS mean_Nacelle_temperature,
    AVG(Bearing_temperature) AS mean_Bearing_temperature,
    AVG(Generator_speed) AS mean_Generator_speed,
    AVG(Yaw_angle) AS mean_Yaw_angle,
    AVG(Wind_direction) AS mean_Wind_direction,
    AVG(Wheel_hub_temperature) AS mean_Wheel_hub_temperature,
    AVG(Gear_box_inlet_temperature) AS mean_Gear_box_inlet_temperature
FROM
    wind_turbine;
    
-- Median value calculate --
WITH RankedValues AS (
    SELECT
        Wind_speed,
        Power,
        Nacelle_ambient_temperature,
        Generator_bearing_temperature,
        Gear_oil_temperature,
        Ambient_temperature,
        Rotor_Speed,
        Nacelle_temperature,
        Bearing_temperature,
        Generator_speed,
        Yaw_angle,
        Wind_direction,
        Wheel_hub_temperature,
        Gear_box_inlet_temperature,
        ROW_NUMBER() OVER (ORDER BY Wind_speed) AS row_num
    FROM
        wind_turbine
)
, MedianCTE AS (
    SELECT
        AVG(Wind_speed) AS median_Wind_speed,
        AVG(Power) AS median_Power,
        AVG(Nacelle_ambient_temperature) AS median_Nacelle_ambient_temperature,
        AVG(Generator_bearing_temperature) AS median_Generator_bearing_temperature,
        AVG(Gear_oil_temperature) AS median_Gear_oil_temperature,
        AVG(Ambient_temperature) AS median_Ambient_temperature,
        AVG(Rotor_Speed) AS median_Rotor_Speed,
        AVG(Nacelle_temperature) AS median_Nacelle_temperature,
        AVG(Bearing_temperature) AS median_Bearing_temperature,
        AVG(Generator_speed) AS median_Generator_speed,
        AVG(Yaw_angle) AS median_Yaw_angle,
        AVG(Wind_direction) AS median_Wind_direction,
        AVG(Wheel_hub_temperature) AS median_Wheel_hub_temperature,
        AVG(Gear_box_inlet_temperature) AS median_Gear_box_inlet_temperature
    FROM
        RankedValues
    WHERE
        row_num >= (SELECT COUNT(*) FROM wind_turbine) / 2
        AND row_num <= (SELECT COUNT(*) FROM wind_turbine) / 2 + 1
)
-- Select the calculated medians
SELECT
    median_Wind_speed,
    median_Power,
    median_Nacelle_ambient_temperature,
    median_Generator_bearing_temperature,
    median_Gear_oil_temperature,
    median_Ambient_temperature,
    median_Rotor_Speed,
    median_Nacelle_temperature,
    median_Bearing_temperature,
    median_Generator_speed,
    median_Yaw_angle,
    median_Wind_direction,
    median_Wheel_hub_temperature,
    median_Gear_box_inlet_temperature
FROM
    MedianCTE;

-- 2nd moment business decision - Variance, Standard Deviation, and Range
SELECT
    STDDEV(Wind_speed) AS std_dev_Wind_speed,
    VARIANCE(Wind_speed) AS variance_Wind_speed,
    MAX(Wind_speed) - MIN(Wind_speed) AS range_Wind_speed,

    STDDEV(Power) AS std_dev_Power,
    VARIANCE(Power) AS variance_Power,
    MAX(Power) - MIN(Power) AS range_Power,

    STDDEV(Nacelle_ambient_temperature) AS std_dev_Nacelle_ambient_temperature,
    VARIANCE(Nacelle_ambient_temperature) AS variance_Nacelle_ambient_temperature,
    MAX(Nacelle_ambient_temperature) - MIN(Nacelle_ambient_temperature) AS range_Nacelle_ambient_temperature,

    STDDEV(Generator_bearing_temperature) AS std_dev_Generator_bearing_temperature,
    VARIANCE(Generator_bearing_temperature) AS variance_Generator_bearing_temperature,
    MAX(Generator_bearing_temperature) - MIN(Generator_bearing_temperature) AS range_Generator_bearing_temperature,

    STDDEV(Gear_oil_temperature) AS std_dev_Gear_oil_temperature,
    VARIANCE(Gear_oil_temperature) AS variance_Gear_oil_temperature,
    MAX(Gear_oil_temperature) - MIN(Gear_oil_temperature) AS range_Gear_oil_temperature,

    STDDEV(Ambient_temperature) AS std_dev_Ambient_temperature,
    VARIANCE(Ambient_temperature) AS variance_Ambient_temperature,
    MAX(Ambient_temperature) - MIN(Ambient_temperature) AS range_Ambient_temperature,

    STDDEV(Rotor_Speed) AS std_dev_Rotor_Speed,
    VARIANCE(Rotor_Speed) AS variance_Rotor_Speed,
    MAX(Rotor_Speed) - MIN(Rotor_Speed) AS range_Rotor_Speed,

    STDDEV(Nacelle_temperature) AS std_dev_Nacelle_temperature,
    VARIANCE(Nacelle_temperature) AS variance_Nacelle_temperature,
    MAX(Nacelle_temperature) - MIN(Nacelle_temperature) AS range_Nacelle_temperature,

    STDDEV(Bearing_temperature) AS std_dev_Bearing_temperature,
    VARIANCE(Bearing_temperature) AS variance_Bearing_temperature,
    MAX(Bearing_temperature) - MIN(Bearing_temperature) AS range_Bearing_temperature,

    STDDEV(Generator_speed) AS std_dev_Generator_speed,
    VARIANCE(Generator_speed) AS variance_Generator_speed,
    MAX(Generator_speed) - MIN(Generator_speed) AS range_Generator_speed,

    STDDEV(Yaw_angle) AS std_dev_Yaw_angle,
    VARIANCE(Yaw_angle) AS variance_Yaw_angle,
    MAX(Yaw_angle) - MIN(Yaw_angle) AS range_Yaw_angle,

    STDDEV(Wind_direction) AS std_dev_Wind_direction,
    VARIANCE(Wind_direction) AS variance_Wind_direction,
    MAX(Wind_direction) - MIN(Wind_direction) AS range_Wind_direction,

    STDDEV(Wheel_hub_temperature) AS std_dev_Wheel_hub_temperature,
    VARIANCE(Wheel_hub_temperature) AS variance_Wheel_hub_temperature,
    MAX(Wheel_hub_temperature) - MIN(Wheel_hub_temperature) AS range_Wheel_hub_temperature,

    STDDEV(Gear_box_inlet_temperature) AS std_dev_Gear_box_inlet_temperature,
    VARIANCE(Gear_box_inlet_temperature) AS variance_Gear_box_inlet_temperature,
    MAX(Gear_box_inlet_temperature) - MIN(Gear_box_inlet_temperature) AS range_Gear_box_inlet_temperature
FROM
    wind_turbine;

-- Example for the 3rd moment - Skewness
WITH SkewnessCTE AS (
    SELECT
        AVG(Wind_speed) AS mean_Wind_speed,
        STDDEV(Wind_speed) AS stddev_Wind_speed,
        AVG(Power) AS mean_Power,
        STDDEV(Power) AS stddev_Power,
        AVG(Nacelle_ambient_temperature) AS mean_Nacelle_ambient_temperature,
        STDDEV(Nacelle_ambient_temperature) AS stddev_Nacelle_ambient_temperature
    FROM
        wind_turbine
)

-- Select the calculated skewness for each column
SELECT
    mean_Wind_speed,
    stddev_Wind_speed,
    (SUM(POWER(Wind_speed - mean_Wind_speed, 3)) / COUNT(*)) / POWER(stddev_Wind_speed, 3) AS skewness_Wind_speed,
    mean_Power,
    stddev_Power,
    (SUM(POWER(Power - mean_Power, 3)) / COUNT(*)) / POWER(stddev_Power, 3) AS skewness_Power,
    mean_Nacelle_ambient_temperature,
    stddev_Nacelle_ambient_temperature,
    (SUM(POWER(Nacelle_ambient_temperature - mean_Nacelle_ambient_temperature, 3)) / COUNT(*)) / POWER(stddev_Nacelle_ambient_temperature, 3) AS skewness_Nacelle_ambient_temperature
FROM
    wind_turbine
CROSS JOIN
    SkewnessCTE
GROUP BY
    mean_Wind_speed,
    stddev_Wind_speed,
    mean_Power,
    stddev_Power,
    mean_Nacelle_ambient_temperature,
    stddev_Nacelle_ambient_temperature;    -- like that we can calculate skewness of all columns

-- Example for the 4th moment - Kurtosis
SELECT
    (SUM(POWER(Wind_speed - mean_wind, 4)) / COUNT(*)) / POWER(STDDEV(Wind_speed), 4) AS kurtosis_Win_speed,
    (SUM(POWER(Power - mean_Power, 4)) / COUNT(*)) / POWER(STDDEV(Power), 4) AS kurtosis_Power,
    (SUM(POWER(Nacelle_ambient_temperature - mean_Nacelle_ambient_temperature, 4)) / COUNT(*)) / POWER(STDDEV(Nacelle_ambient_temperature), 4) AS kurtosis_Nacelle_ambient_temperature
FROM (
    SELECT
        Wind_speed,
        AVG(Wind_speed) OVER () AS mean_wind,
        Power,
        AVG(Power) OVER () AS mean_Power,
        Nacelle_ambient_temperature,
        AVG(Nacelle_ambient_temperature) OVER () AS mean_Nacelle_ambient_temperature
    FROM
        wind_turbine
) AS subquery;     -- like that we can calculate kurtosis of all column

-- Calculate the quartiles and IQR
WITH WindSpeedRanked AS (
    SELECT
        Wind_speed,
        ROW_NUMBER() OVER (ORDER BY Wind_speed) AS row_num,
        COUNT(*) OVER () AS total_rows
    FROM
        wind_turbine
)
, QuartilesCTE AS (
    SELECT
        MAX(CASE WHEN row_num <= CEIL(0.25 * total_rows) THEN Wind_speed END) AS Q1,
        MAX(CASE WHEN row_num <= CEIL(0.75 * total_rows) THEN Wind_speed END) AS Q3
    FROM
        WindSpeedRanked
)
, IQRCTE AS (
    SELECT
        Q1,
        Q3,
        Q3 - Q1 AS IQR
    FROM
        QuartilesCTE
)
-- Identify outliers
SELECT
    Wind_speed
FROM
    wind_turbine
JOIN
    IQRCTE ON Wind_speed < Q1 - 1.5 * IQR OR Wind_speed > Q3 + 1.5 * IQR;  --  I used the ROW_NUMBER() window function to rank the Wind_speed values and calculated the quartiles based on the ranks. The CEIL function is used to handle cases where the calculated row numbers are not integers.

-- Data Distribution(Histogram of a column) --
SELECT Failure_status, COUNT(*) as frequency
FROM wind_turbine
GROUP BY Failure_status
ORDER BY frequency DESC;

-- Data exploration 
SELECT * FROM wind_turbine LIMIT 10; 


-------------- DATA PREPROCESSING --------------------

-- Drop rows with missing values
SET SQL_SAFE_UPDATES = 0;
SELECT
    SUM(CASE WHEN Wind_speed IS NULL THEN 1 ELSE 0 END) AS missing_Wind_speed,
    SUM(CASE WHEN Power IS NULL THEN 1 ELSE 0 END) AS missing_Power,
    SUM(CASE WHEN Nacelle_ambient_temperature IS NULL THEN 1 ELSE 0 END) AS missing_Nacelle_ambient_temperature,
    SUM(CASE WHEN Generator_bearing_temperature IS NULL THEN 1 ELSE 0 END) AS missing_Generator_bearing_temperature,
    SUM(CASE WHEN Gear_oil_temperature IS NULL THEN 1 ELSE 0 END) AS missing_Gear_oil_temperature,
    SUM(CASE WHEN Ambient_temperature IS NULL THEN 1 ELSE 0 END) AS missing_Ambient_temperature,
    SUM(CASE WHEN Rotor_Speed IS NULL THEN 1 ELSE 0 END) AS missing_Rotor_Speed,
    SUM(CASE WHEN Nacelle_temperature IS NULL THEN 1 ELSE 0 END) AS missing_Nacelle_temperature,
    SUM(CASE WHEN Bearing_temperature IS NULL THEN 1 ELSE 0 END) AS missing_Bearing_temperature,
    SUM(CASE WHEN Generator_speed IS NULL THEN 1 ELSE 0 END) AS missing_Generator_speed,
    SUM(CASE WHEN Yaw_angle IS NULL THEN 1 ELSE 0 END) AS missing_Yaw_angle,
    SUM(CASE WHEN Wind_direction IS NULL THEN 1 ELSE 0 END) AS missing_Wind_direction,
    SUM(CASE WHEN Wheel_hub_temperature IS NULL THEN 1 ELSE 0 END) AS missing_Wheel_hub_temperature,
    SUM(CASE WHEN Gear_box_inlet_temperature IS NULL THEN 1 ELSE 0 END) AS missing_Gear_box_inlet_temperature,
    SUM(CASE WHEN Failure_status IS NULL THEN 1 ELSE 0 END) AS missing_Failure_status
FROM
    wind_turbine;
    
-- Remove Duplicates 
SELECT DISTINCT
    Wind_speed,
    Power,
    Nacelle_ambient_temperature,
    Generator_bearing_temperature,
    Gear_oil_temperature,
    Ambient_temperature,
    Rotor_Speed,
    Nacelle_temperature,
    Bearing_temperature,
    Generator_speed,
    Yaw_angle,
    Wind_direction,
    Wheel_hub_temperature,
    Gear_box_inlet_temperature,
    Failure_status
FROM
    wind_turbine;

-- Correlation Coefficient
SELECT
    SUM((Wind_speed - avg_wind) * (Rotor_Speed - avg_rotor)) /
    (COUNT(*) * STDDEV(Wind_speed) * STDDEV(Rotor_Speed)) AS correlation
FROM (
    SELECT
        Wind_speed,
        Rotor_Speed,
        AVG(Wind_speed) OVER () AS avg_wind,
        AVG(Rotor_Speed) OVER () AS avg_rotor
    FROM
        wind_turbine
) AS subquery;

-- Transforming Data Types: Convert String to Numeric 
UPDATE wind_turbine
SET Failure_status = COALESCE(NULLIF(Failure_status, ''), '0')
WHERE Failure_status IS NOT NULL;
select * from wind_turbine;

-- REMOVING OUTLIERS:-
select * from wind_turbine;
-- Calculate z-scores for specified columns
WITH ZScoresCTE AS (
    SELECT
        Wind_speed,
        Power,
        Nacelle_ambient_temperature,
        Generator_bearing_temperature,
        Gear_oil_temperature,
        Ambient_temperature,
        Rotor_Speed,
        Nacelle_temperature,
        Bearing_temperature,
        Generator_speed,
        Yaw_angle,
        Wind_direction,
        Wheel_hub_temperature,
        Gear_box_inlet_temperature,
        (Wind_speed - AVG(Wind_speed) OVER ()) / STDDEV(Wind_speed) OVER () AS z_wind_speed,
        (Power - AVG(Power) OVER ()) / STDDEV(Power) OVER () AS z_power,
        (Nacelle_ambient_temperature - AVG(Nacelle_ambient_temperature) OVER ()) / STDDEV(Nacelle_ambient_temperature) OVER () AS z_nacelle_ambient_temp,
        (Generator_bearing_temperature - AVG(Generator_bearing_temperature) OVER ()) / STDDEV(Generator_bearing_temperature) OVER () AS z_gen_bearing_temp,
        (Gear_oil_temperature - AVG(Gear_oil_temperature) OVER ()) / STDDEV(Gear_oil_temperature) OVER () AS z_gear_oil_temp,
        (Ambient_temperature - AVG(Ambient_temperature) OVER ()) / STDDEV(Ambient_temperature) OVER () AS z_ambient_temp,
        (Rotor_Speed - AVG(Rotor_Speed) OVER ()) / STDDEV(Rotor_Speed) OVER () AS z_rotor_speed,
        (Nacelle_temperature - AVG(Nacelle_temperature) OVER ()) / STDDEV(Nacelle_temperature) OVER () AS z_nacelle_temp,
        (Bearing_temperature - AVG(Bearing_temperature) OVER ()) / STDDEV(Bearing_temperature) OVER () AS z_bearing_temp,
        (Generator_speed - AVG(Generator_speed) OVER ()) / STDDEV(Generator_speed) OVER () AS z_gen_speed,
        (Yaw_angle - AVG(Yaw_angle) OVER ()) / STDDEV(Yaw_angle) OVER () AS z_yaw_angle,
        (Wind_direction - AVG(Wind_direction) OVER ()) / STDDEV(Wind_direction) OVER () AS z_wind_direction,
        (Wheel_hub_temperature - AVG(Wheel_hub_temperature) OVER ()) / STDDEV(Wheel_hub_temperature) OVER () AS z_wheel_hub_temp,
        (Gear_box_inlet_temperature - AVG(Gear_box_inlet_temperature) OVER ()) / STDDEV(Gear_box_inlet_temperature) OVER () AS z_gear_box_inlet_temp
    FROM
        wind_turbine
)
-- Identify outliers based on z-scores
SELECT
    *
FROM
    ZScoresCTE
WHERE
    ABS(z_wind_speed) > 2
    OR ABS(z_power) > 2
    OR ABS(z_nacelle_ambient_temp) > 2
    OR ABS(z_gen_bearing_temp) > 2
    OR ABS(z_gear_oil_temp) > 2
    OR ABS(z_ambient_temp) > 2
    OR ABS(z_rotor_speed) > 2
    OR ABS(z_nacelle_temp) > 2
    OR ABS(z_bearing_temp) > 2
    OR ABS(z_gen_speed) > 2
    OR ABS(z_yaw_angle) > 2
    OR ABS(z_wind_direction) > 2
    OR ABS(z_wheel_hub_temp) > 2
    OR ABS(z_gear_box_inlet_temp) > 2;
  
    
-- 1) Univariate Analysis:

-- Mean and Standard Deviation of Wind_speed
SELECT AVG(Wind_speed) AS mean_Wind_speed, STDDEV(Wind_speed) AS stddev_Wind_speed
FROM wind_turbine;

-- Histogram of Wind_speed (example with bins)
SELECT
  FLOOR(Wind_speed/10)*10 AS bin,
  COUNT(*) AS frequency
FROM wind_turbine
GROUP BY bin
ORDER BY bin;

-- 2) Bivariate Analysis:

-- Correlation between Wind Speed and Rotor_Speed:
SELECT
    SUM((Wind_speed - avg_wind) * (Rotor_Speed - avg_rotor_speed)) /
    (COUNT(*) * STDDEV(Wind_speed) * STDDEV(Rotor_Speed)) AS correlation
FROM (
    SELECT
        Wind_speed,
        Rotor_Speed,
        AVG(Wind_speed) OVER () AS avg_wind,
        AVG(Rotor_Speed) OVER () AS avg_rotor_speed
    FROM
        wind_turbine
) AS subquery;

-- Scatter Plot for Wind Speed and Power (assuming a plotting tool is used for visualization):
SELECT
    Wind_speed,
    Power
FROM wind_turbine;

-- 3) Multivariate Analysis:

-- Box Plot for Power Across Different Failure Status:
SELECT
    Failure_status,
    Power
FROM wind_turbine;

-- Grouped Analysis:
SELECT
    Failure_status,
    AVG(Wind_speed) AS avg_wind_speed,
    AVG(Power) AS avg_power
FROM wind_turbine
GROUP BY Failure_status;

-- removing outliers
WITH ZScoreStats AS (
    SELECT
        AVG(Gear_box_inlet_temperature) AS Mean,
        STDDEV(Gear_box_inlet_temperature) AS StdDev
    FROM wind_turbine
)
DELETE FROM wind_turbine
WHERE ABS((Gear_box_inlet_temperature - (SELECT Mean FROM ZScoreStats)) / (SELECT StdDev FROM ZScoreStats)) > 3;  -- We can take all the Columns to remove outliers by the same formula.
select * from wind_turbine;   -- Total Outliers = 563




    


    










    












