USE SQLTUT;
select *
from dbo.covidDeaths
order by 3,4


select *
from dbo.covidvax
order by 3,4


--select date we are going to be using 

select location, date, total_cases, new_cases, total_deaths, population
from dbo.covidDeaths
order by 1,2

-- looking at total cases vs total deaths 

-- shows liklihood of dying if you contract covid in saudi arabia

select location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as deathPer
from dbo.covidDeaths
where location like '%saudi%'
order by 1,2

-- looking at countries with the highest infection rate compared to population

select location, max(total_cases) as highestInfectionCount, population, 
MAX(total_cases/population) * 100 as PercentPopulationInfected
from dbo.covidDeaths
--where location like '%saudi%'
Group by location, population
order by PercentPopulationInfected desc


--Showing coutries with Highest Death Count per population

select location, MAX(cast(TOTAL_DEATHS as int)) AS totaldeathcount
from dbo.covidDeaths
where continent is not null
Group by location
order by totaldeathcount desc


-- BREAKING THIGNS DOWN BY CONTINENT

select CONTINENT, sum(cast(new_DEATHS as int)) AS totaldeathcount
from dbo.covidDeaths
where continent is not null
Group by CONTINENT
order by totaldeathcount desc


-- GLOBAL NUMBERS

select  SUM(NEW_CASES) as total_cases, SUM(CAST(NEW_DEATHS AS INT)) as total_deaths, SUM(CAST(NEW_DEATHS AS INT))/SUM(NEW_CASES)*100 AS deathpercentage
from dbo.covidDeaths
--where location like '%saudi%'
where continent is not null
-- GROUP BY DATE
order by 1,2

-- looking at total Population vs Vaxes

SELECT deaths.continent, deaths.location, deaths.date, deaths.population, vax.new_vaccinations
 , SUM(CAST(vax.new_vaccinations AS BIGINT)) OVER (Partition by deaths.location ORDER BY DEATHS.LOCATION,
 DEATHS.DATE) AS VaxCount
FROM DBO.covidDeaths deaths
JOIN dbo.covidVax vax
   ON deaths.location = vax.location
   where deaths.continent is not null 
   AND deaths.date = vax.date 
   order by 2,3


-- USE CTE 

with popvsVac (continent, location, date, population, vaxcount, new_vaccinations) 
as(
SELECT deaths.continent, deaths.location, deaths.date, deaths.population, vax.new_vaccinations
 , SUM(CAST(vax.new_vaccinations AS BIGINT)) OVER (Partition by deaths.location ORDER BY DEATHS.LOCATION,
 DEATHS.DATE) AS VaxCount
FROM DBO.covidDeaths deaths
JOIN dbo.covidVax vax
   ON deaths.location = vax.location
   where deaths.continent is not null 
   AND deaths.date = vax.date 
--order by 2,3
)
select *, (vaxcount/population)*100
from popvsVac



select distinct location, sum(new_cases) as total_cases
from dbo.covidDeaths
where continent is not null
Group by location
order by total_cases desc 




SELECT Location, population, date, MAX(total_cases) as highestinfCount, max((total_cases/population))*100 as percentpopulationinf
from dbo.covidDeaths
where location = 'china' 
group by Location, population, date
order by percentpopulationinf desc  