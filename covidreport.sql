SELECT*
FROM PortfoloioProject..CDeaths

SELECT*
FROM PortfoloioProject..CovidVac

SELECT location, date,continent, population,total_cases,total_deaths, CAST(total_deaths AS FLOAT)/CAST(total_cases AS FLOAT)*100 AS deathpercentage
FROM PortfoloioProject..CDeaths
ORDER BY deathpercentage DESC;

SELECT location, date, population, CAST(total_cases AS FLOAT)/CAST(population AS FLOAT)*100 AS covidpercentage
FROM PortfoloioProject..CDeaths
ORDER BY covidpercentage DESC;

SELECT location, population,SUM(CAST(total_cases AS BIGINT)) as totalcases,SUM(CAST(total_deaths AS BIGINT))as totaldeaths
FROM PortfoloioProject..CDeaths
GROUP BY location,population
ORDER BY 1,2 ;

SELECT location, population, CAST(total_cases AS FLOAT)/CAST(population AS FLOAT)*100 as covidpercentage 
FROM PortfoloioProject..CDeaths
GROUP BY location,population,total_cases;

SELECT location,date,population,MAX(total_cases)as maxcases
FROM PortfoloioProject..CDeaths
WHERE location ='Pakistan'
GROUP BY location,population,date
ORDER BY 3,4 DESC;

SELECT location,MAX(total_deaths)as deaths
FROM PortfoloioProject..CDeaths
GROUP BY location
HAVING MAX(total_deaths) = (SELECT MAX(total_deaths) FROM PortfoloioProject..CDeaths)

SELECT location,population, MAX(total_deaths) as deaths
FROM PortfoloioProject..CDeaths
GROUP BY location,population
ORDER BY deaths DESC

SELECT continent,population
FROM PortfoloioProject..CDeaths
WHERE continent is not null
GROUP BY continent,population

SELECT D.location,D.date,D.population,MAX(V.new_vaccinations)
FROM PortfoloioProject..CDeaths D
JOIN PortfoloioProject..CovidVac V
ON D.location=V.location 
and
D.date=V.date 
GROUP BY D.location,D.date,D.population
Having MAX(V.new_vaccinations)=( SELECT TOP 1 MAX(V.new_vaccinations) FROM PortfoloioProject..CovidVac) 
ORDER BY 3DESC;

--CTE
WITH world as(SELECT location,date,population,MAX(total_cases)as maxcases
FROM PortfoloioProject..CDeaths
WHERE location NOT IN ('international', 'world') and population is not null
GROUP BY location,population,date
)
SELECT location, population
FROM world
group by location,population;



