-- USE CTE 
WITH PopvsVac (Continent, location, Date, Population, new_vaccinations, rollingcount_ofpeoplevaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, population, dea.new_vaccinations, 
       SUM(dea.new_vaccinations) OVER 
       (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rollingcount_ofpeoplevaccinated
FROM `SQL Project`.CovidVaccinations AS dea
JOIN CovidDeaths AS vac
ON dea.location = vac.location 
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)
SELECT *,(rollingcount_ofpeoplevaccinated/Population)*100
FROM PopvsVac
WHERE continent = 'Europe'