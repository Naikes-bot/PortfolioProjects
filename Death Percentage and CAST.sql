SELECT  SUM(new_cases), 
			  SUM(CAST(new_deaths AS SIGNED)), 
              SUM(CAST(new_deaths AS SIGNED))/SUM(new_cases)*100 AS death_percentage
FROM CovidDeaths
WHERE continent IS NOT NULL GROUP BY date
ORDER BY 1,2; 