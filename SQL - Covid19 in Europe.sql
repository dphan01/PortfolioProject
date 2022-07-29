-- SQL 'Covid-19' case study as of 2022 July 18, data retrieved from: Our World in Data

-- #1 View the two datasets
SELECT *
FROM [Entry-level Portfolio Projects]..['Europe Covid Cases$']
ORDER BY location asc

SELECT *
FROM [Entry-level Portfolio Projects]..['Europe Covid Vaccinations$']
ORDER BY 3 asc -- location is the third column

-- #2 The death rate ratio
-- Change datatypes for arithmetic operations 
ALTER table [Entry-level Portfolio Projects]..['Europe Covid Cases$']
ALTER column total_cases float

ALTER table [Entry-level Portfolio Projects]..['Europe Covid Cases$']
ALTER column total_deaths float

-- National death rates according to dates 
SELECT location, population, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_rate
FROM [Entry-level Portfolio Projects]..['Europe Covid Cases$']
ORDER BY 1, 3

-- Advanced tasks: using CTEs to analyze the death rates in details (Czechia vs. Europe)
-- Task 1: Calculate the EU average death rate > Answer: roughly 2.32
WITH 
	EU_AVG_death_rate AS
(
	SELECT continent, location, population, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_rate
	FROM [Entry-level Portfolio Projects]..['Europe Covid Cases$']
)
SELECT continent, AVG(death_rate) as EU_AVG_death_rate
FROM EU_AVG_death_rate
WHERE total_deaths is not null
GROUP BY continent

-- Task 2: Calculate the Czech average death rate using wildcards > Answer: roughly 1.68
-- Result: Czechia were regionally tackling the pandemic pretty well as the country had the average death rate below the contient's
WITH 
	Czech_AVG_death_rate AS
(
	SELECT location, population, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_rate
	FROM [Entry-level Portfolio Projects]..['Europe Covid Cases$']
	WHERE location like '%czech%'
)
SELECT location, AVG(death_rate) as CZ_AVG_death_rate
FROM Czech_AVG_death_rate
GROUP BY location

-- Task 3: Create a list of all average death rates to compare Czech performances 
-- Result: ranked 19/48 of the countries with public data
WITH 
	All_AVG_death_rates AS
(
	SELECT location, population, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_rate
	FROM [Entry-level Portfolio Projects]..['Europe Covid Cases$']
)
SELECT location, AVG(death_rate) as AVG_death_rates
FROM All_AVG_death_rates
WHERE total_deaths is not null
GROUP BY location
ORDER BY AVG_death_rates

-- #3: The Likelihood of Covid Infection Rate based on population of diffrent countries
SELECT location, population, MAX(total_cases) as highest_infection_count, MAX((total_cases/population))*100 as highest_infection_rate
FROM [Entry-level Portfolio Projects]..['Europe Covid Cases$']
WHERE total_cases is not null
GROUP BY location, population
ORDER BY 4  desc

-- Advanced tasks: Using CASE statement combined with CTEs
-- Task 1: Classify the levels of infection risks among all EU nations 
WITH zones AS
(
	SELECT location, population, MAX(total_cases) as highest_infection_count, MAX((total_cases/population))*100 as highest_infection_rate
	FROM [Entry-level Portfolio Projects]..['Europe Covid Cases$']
	GROUP BY location, population
)
SELECT  location, highest_infection_rate, 
CASE
	WHEN highest_infection_rate >= 50 THEN 'High risk'
	WHEN highest_infection_rate < 50 and highest_infection_rate > 20 THEN 'Medium Risk'
	WHEN highest_infection_rate <= 20 and highest_infection_rate > 0 THEN 'Low Risk'
	ELSE 'Unknown' -- for the NULL results 
END AS risk_levels
FROM zones
ORDER BY highest_infection_rate desc

-- Calculate the severity rate of ICU patients based on new cases per day
SELECT location, date, CAST(new_cases as int), CAST(icu_patients as int), CAST(icu_patients as int)/NULLIF(CAST(new_cases as int),0)*100
FROM [Entry-level Portfolio Projects]..['Europe Covid Cases$']

SELECT location, AVG(CAST(new_cases as float)) AVG_new_cases, AVG(CAST(icu_patients as float)) AVG_icu_patients, AVG(CAST(icu_patients as float)/CAST(new_cases as float)*100) severity_rate
FROM [Entry-level Portfolio Projects]..['Europe Covid Cases$']
WHERE 
	new_cases <> 0 and
	new_cases is not null and
	icu_patients is not null
GROUP BY location
ORDER BY severity_rate desc

