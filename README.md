#Flu Shot Dashboard SQL Query

## Overview
This README documents the SQL queries used for generating the data for the Flu Shot Dashboard. The dashboard visualizes flu vaccination coverage by various demographics and over time. The queries provided here are part of the data processing pipeline that feeds into the visualization tool.

## File Description
- `flu_shot_dashboard_queries.sql`: Contains the SQL commands to create temporary tables and select the necessary data for the Flu Shot Dashboard.

## SQL Query Breakdown
The SQL file consists of three main parts:

### 1. Active Patients Temporary Table
- This temporary table (`active_patients`) is created to identify unique patients who had encounters within the date range of 2020-01-01 to 2022-12-31, are alive (`deathdate IS NULL`), and are at least 6 months old.
- It extracts the `patient` identifier from the `encounters` and `patients` tables.

### 2. Flu Shots in 2022 Temporary Table
- Another temporary table (`flu_shot_2022`) identifies patients who received their first flu shot within the year 2022.
- The `MIN(date)` function is used to get the earliest flu shot date for each patient, filtering by the flu shot code `5302`.

### 3. Final Select Query
- This query selects patient demographics and flu shot information.
- It calculates the patient's age as of the end of 2022 and determines whether they had a flu shot in 2022 (`flu_shot_2022`).
- A left join with `flu_shot_2022` table is performed to include all patients, marking with `1` if they had a flu shot and `0` otherwise.

## Usage
- The SQL queries should be run in a PostgreSQL database where the `patients`, `encounters`, and `immunizations` tables exist.
- Ensure that the database connection settings are configured before running the queries.
- These queries are intended for a one-time run to generate data for the current state of the dashboard.

## Dashboard Description
The Flu Shot Dashboard presents the following visualizations:
- `Flu Shots by Age`: Distribution of flu vaccinations by age group.
- `Flu Shots by Race`: Comparison of flu vaccination rates among different racial groups.
- `Flu Shot by County`: The number of flu shots administered across different counties.
- `Running Sum of Flu Shots`: A cumulative graph showing the total number of flu shots administered over the months of 2022.

## Dependencies
- PostgreSQL or compatible database
- Access to the relevant healthcare database with `patients`, `encounters`, and `immunizations` tables.

