--PortofolioProjects

Select * 
from  PortfolioProjects..CovidDeaths

Select * 
from PortfolioProjects..CovidVaccinations

 --Data we are Using

 Select Location, date, total_Cases, New_Cases, Population
 from PortfolioProjects..CovidDeaths
 Where continent is not null
 Order by 1,2

 -- Showing The Total Deaths Vs Total Cases

 Select Location, Date , Population,Total_Cases, Total_Deaths, (total_deaths/Total_cases)*100 DeathRatePercent
 from PortfolioProjects..CovidDeaths
 Where continent is not null
 Order by 1,2

 --Showing Total cases vs Population

 Select Location, Date, Population, Total_cases, (total_cases/population)*100 InfectionRate
 from PortfolioProjects..CovidDeaths
 Where continent is not null
 order by 1,2

 -- Showing Countries with highest Infection rate compered to Population

Select Location, Population,MAX(tOTAL_cases)MaxCases, Max((total_cases/population))*100 InfectionRate
 from PortfolioProjects..CovidDeaths
 Where continent is not null
 Group by location, population
 order by 1,2


 -- Showing Countries with highest Death rate per Population

 Select Location, Population, Sum(Cast(New_Deaths as int))MaxDeaths, sum((new_deaths/population))*100 DeathRate
 from PortfolioProjects..CovidDeaths
 Where continent is not null
 Group by location, population
 Order BY MaxDeaths Desc

 Select sum(Cast (new_deaths as int))
 from PortfolioProjects..CovidDeaths
 Where location  like '%state%'

 -- Looking into Continents With highest Deathcount

 Select continent, Sum(Cast(new_deaths as int))DeathCount
 from PortfolioProjects..CovidDeaths
 Where continent is not null
 Group by continent
 Order by DeathCount Desc

 -- Lookint into Global Numbers

 Select Date, Sum(New_Cases)WTotalCases ,Sum(Cast(new_deaths as int))WTotalDeaths, 
 Sum(Cast(new_deaths as int))/Sum(New_Cases)*100 WDeathParcent
 From PortfolioProjects..CovidDeaths
 Where continent is not null
 Group by Date
 Order by 1,2
   
   -- Total Cases, Deaths and Death Parcentage of entire World 

 Select Sum(New_Cases)WTotalCases ,Sum(Cast(new_deaths as int))WTotalDeaths, 
 Sum(Cast(new_deaths as int))/Sum(New_Cases)*100 WDeathParcent
 From PortfolioProjects..CovidDeaths
 Where continent is not null
 --Group by Date
 Order by 1,2

 
 -- Showing Total Population Vs Vaccination

 Select Dea.location, Dea.date, Dea.population, Vac.new_vaccinations
 from PortfolioProjects..CovidDeaths Dea
 Join PortfolioProjects..CovidVaccinations Vac
 On Dea.date = Vac.date
 And Dea.location = Vac.location
 Where dea.continent is not null
 Order by 1,2

 --Rolling Count Showing The Sum of Vaccinations

 Select Dea.location, Dea.date, Dea.population, Vac.new_vaccinations,
 Sum(Cast (Vac.new_vaccinations as int)) 
 Over (Partition By dea.Location Order by Dea.location, dea.date) AS RollingPeopleVaccinated
 from PortfolioProjects..CovidDeaths Dea
 Join PortfolioProjects..CovidVaccinations Vac
 On Dea.date = Vac.date
 And Dea.location = Vac.location
 Where dea.continent is not null
 Order by 1,2


 -- Showing People Vaccinated Parcentage

-- USE CTE

WITH PopVsVac (Location, date, population, New_vaccinations,RollingPeopleVaccinated)
as 
( Select Dea.location, Dea.date, Dea.population, Vac.new_vaccinations,
 Sum(Cast (Vac.new_vaccinations as int)) 
 Over (Partition By dea.Location Order by Dea.location, dea.date) AS RollingPeopleVaccinated
 from PortfolioProjects..CovidDeaths Dea
 Join PortfolioProjects..CovidVaccinations Vac
 On Dea.date = Vac.date
 And Dea.location = Vac.location
 Where dea.continent is not null
 --and dea.location like '%states%'
)
Select *, (RollingPeopleVaccinated/population)*100 VaccinatedParcent
from PopVsVac


-- Creating TempTable

Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(Location VarChar(250),
 Date date,
 Population numeric,
 New_Vaccination Numeric,
 RollingPeopleVaccinated Numeric)

Insert into #PercentPopulationVaccinated
Select Dea.location, Dea.date, Dea.population, Vac.new_vaccinations,
 Sum(Cast (Vac.new_vaccinations as int)) 
 Over (Partition By dea.Location Order by Dea.location, dea.date) AS RollingPeopleVaccinated
 from PortfolioProjects..CovidDeaths Dea
 Join PortfolioProjects..CovidVaccinations Vac
 On Dea.date = Vac.date
 And Dea.location = Vac.location
 Where dea.continent is not null
 --and dea.location like '%states%'

 Select *, (RollingPeopleVaccinated/population)*100 VaccinatedParcent
 from #PercentPopulationVaccinated



 -- Creating View To Store Data for Later Visualization 

 Create View PercentPopulationVaccinated 
 as 
	Select Dea.location, Dea.date, Dea.population, Vac.new_vaccinations,
	Sum(Cast (Vac.new_vaccinations as int)) 
	Over (Partition By dea.Location Order by Dea.location, dea.date) AS RollingPeopleVaccinated
	from PortfolioProjects..CovidDeaths Dea
	Join PortfolioProjects..CovidVaccinations Vac
	On Dea.date = Vac.date
	And Dea.location = Vac.location
	Where dea.continent is not null 
	--and dea.location like '%states%'

select *
from PercentPopulationVaccinated 
