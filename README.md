## 🦠 COVID-19 Data Exploration with SQL

### 📊 Project Overview

This project is a comprehensive **SQL-based data exploration** of the global COVID-19 pandemic using two datasets:

* **CovidDeaths**
* **CovidVaccinations**

The goal is to uncover trends, compare infection and death rates, evaluate vaccination rollouts, and create views for data visualization in Power BI or other BI tools.

---

### 🎯 Key Business Questions Explored

1. What is the **death rate vs. infection rate** by country?
2. Which countries had the **highest infection and death rates** relative to population?
3. What does the **global progression of cases and deaths** look like over time?
4. How many people were vaccinated globally and **what percentage of the population** was covered?
5. Which **continents and countries** had the highest number of deaths?
6. How can we prepare the dataset for **BI tools** using temporary tables and views?

---

### 🛠️ Steps Taken

#### 1. Data Inspection

* Loaded and previewed tables: `CovidDeaths` and `CovidVaccinations`.

#### 2. Cleaning & Filtering

* Removed continent-level data for clarity.
* Filtered rows where `continent IS NOT NULL`.

#### 3. Core Analysis

* **Infection Rate** = `(total_cases / population) * 100`
* **Death Rate** = `(total_deaths / total_cases) * 100`
* Identified countries with:

  * Highest infection rates
  * Highest deaths per population

#### 4. Aggregation by Continent & World

* Aggregated new cases and deaths by date to see **global progression**.
* Calculated **global fatality rate** over time.

#### 5. Vaccination Analysis

* Joined `CovidDeaths` and `CovidVaccinations` on `date` and `location`.
* Created **rolling totals of vaccinations** using `WINDOW FUNCTIONS`.
* Computed **vaccination percentage** = `(rolling people vaccinated / population) * 100`

#### 6. Temporary Table & View Creation

* Built a temp table `#PercentPopulationVaccinated` for reuse.
* Created a view `PercentPopulationVaccinated` to easily pull clean, processed vaccination data into Power BI dashboards.

---

### 📌 Tools & Techniques Used

* **SQL Server**

  * Joins
  * Aggregates (`SUM`, `MAX`)
  * CTEs (Common Table Expressions)
  * Temp Tables
  * Views
  * Window Functions (`OVER`, `PARTITION BY`)
* **Data Modeling for BI**

  * Prepared view specifically for visualization tools like Power BI

---

### 📈 Key Insights

* Some countries had infection rates above **20%** of their population.
* Death rates varied but remained below **5%** in most regions.
* **The United States, India, and Brazil** consistently showed high numbers.
* Vaccination rollouts began gradually, with measurable progress by mid-2021.
* **Rolling totals and percentage vaccinated** metrics provide insight into public health campaign effectiveness.

---

### ✅ Final Notes

This project demonstrates how raw COVID-19 datasets can be transformed into actionable insights using only SQL. The final cleaned data and views are ready for integration into Power BI dashboards to support data-driven public health decisions.

---

Let me know if you'd like a Markdown-formatted version or want to combine this project with Power BI visuals in the same repo!
