-- Temp Table
DROP TABLE IF EXISTS Percent_populationVaccinated;
CREATE TEMPORARY TABLE Percent_populationVaccinated
(Continent VARCHAR(255), 
Location VARCHAR(255), 
date TEXT,
Population NUMERIC, 
New_Vaccinations TEXT, 
rollingcount_ofpeoplevaccinated NUMERIC
);

INSERT INTO Percent_populationVaccinated 
SELECT dea.continent, dea.location, dea.date, population, dea.new_vaccinations, 
       SUM(dea.new_vaccinations) OVER 
       (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rollingcount_ofpeoplevaccinated
FROM `SQL Project`.CovidVaccinations AS dea
JOIN CovidDeaths AS vac
ON dea.location = vac.location 
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
ORDER BY 2,3
LIMIT 50000;

SELECT *
FROM Percent_populationVaccinated