# Rockbuster Stealth Data Analysis Project

## Introduction

Rockbuster Stealth LLC is a global movie rental company that once had physical stores around the world. With the rise of streaming services such as Netflix and Amazon Prime, Rockbuster Stealth plans to leverage its existing movie licenses to launch an online video rental service.

## Objective

The primary goal of this project is to analyze Rockbuster’s data using SQL, gaining insights into customer behavior, geographic patterns, and revenue streams. These insights will help Rockbuster Stealth’s management team make data-driven decisions for the 2020 company strategy and the upcoming launch of the online video rental service.

## Key Focus Areas

### 1. Movie Revenue Analysis
- **Which movies contributed the most/least to revenue gain?**

### 2. Rental Duration
- **What is the average rental duration for all videos?**

### 3. Customer Geography
- **Which countries are Rockbuster customers based in?**
- **Where are customers with high lifetime value located?**

### 4. Regional Sales Analysis
- **Do sales figures vary between geographic regions?**

## Tools

This project uses the following tools:
- **PostgreSQL**: For managing the relational database.
- **SQL**: To query and analyze data.
- **Tableau**: To create a Storyboard for the final presentation

## Data Source

The data used in this project comes from Rockbuster Stealth’s internal systems, which include:
- **Film Inventory**: Information about the available movies.
- **Customer Data**: Information about Rockbuster’s customer base.
- **Payment Data**: Transactions and payment information from customers.

## Repository Structure

- `/Scripts/` SQL scripts for querying the data.
- `/Output/` Power Point Presentation with Tableau visualizations generated from the SQL queries.

## SQL Queries

The following SQL queries are available in the `/Scripts` folder:

- **[Top Countries and Customers Analysis](./Scripts/customer_analysis_top_countries_and_customers.sql)**: Queries to analyze customer data, including:
  - Top 10 countries by customer count.
  - Top 10 country and city combinations by customer count.
  - Top 5 customers based on total amount paid.

- **[Top Customers Payment Analysis](./Scripts/top_customers_payment_analysis.sql)**: Queries to analyze customer payments, including:
  - Average amount paid by the top 5 customers.
  - Distribution of the top 5 customers across different countries.

## Results

Click here for the Storyboard in [Tableau](https://public.tableau.com/app/profile/magdalena.hofbauer/viz/CF_Exercise3_10_RockbusterDataAnalysis/RockbusterAnalysis)

Some expected insights from the analysis include:
- **High Revenue Movies**: Identifying which movies generate the most revenue.
- **Customer Geography**: Understanding where Rockbuster’s most valuable customers are located.
- **Regional Sales Differences**: Insights into how sales vary by region, which can inform targeted marketing strategies.

## Conclusion

This project provides valuable insights into Rockbuster Stealth’s data to inform the company’s strategy as it moves into the online video rental space. By using SQL for data analysis, Rockbuster can make data-driven decisions to stay competitive in the evolving movie rental market.
