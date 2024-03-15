# 💰 Bike-Sales

## Table of Contents
- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools Used](#Tools-Used)
- [Data Loading and Inspection](#Data-Loading-and-Inspection)
- [Exploratory Data Analysis](#Exploratory-Data-Analysis)
- [Data Visualization](#Data-Visualization)
- [Results/Findings](#Results-/-Findings)
- [Recommendations](#Recommendations)

## Project Overview
This project involves the analysis of the sales data of a bike retailer operating in a variety of areas. The analysis involves generating useful insights from the data about the bike retailers' customers, orders, products, stores, staff etc to enable informed business decisions and improve future performance.

## Data Sources
Bike Sales Data: The primary data source for this project is the "Bike Sales.xlsx" file. This file is made up of a number of sheets such as; Customers, Orders, Brands, Order Items, Products, Categories, Staff, Stores and Stock, with each containing detailed information relating to the Bike retailer and its sales

## Tools Used
1. Microsoft Excel - Data Loading and Inspection
2. Microsoft SQL Server Management Studios (SSMS) - Exploratory Data Analysis
3. Microsoft Power BI - Data Visualization

## Data Loading and Inspection
This was a very phase as it entailed loading the data in microsoft excel and use the excel duplicate finding feature to check for possible duplicates (which there weren't)

## Exploratory Data Analysis
This stage of the project was done using SSMS and it involved writing SQL Queries. The SQL Queries written involved using the following SQL functions; select, temporary tables, order by, group by, joins, alter table, update, count etc. The Queries written sought to answer the following questions;
- What are the number of products by model year?
- What are the number of customers by city and state?
- What is the revenue per order?
- Who are our top spending customers?
- What proportion of orders were shipped early and what proportion of orders were shipped late?
- Who are the customers with the most orders?
- What is the revenue generated per brand?
- What is the revenue generated per product category?
- What are our most and least expensive products?
- What model year generated the most revenue?
- Which staff generated the most revenue?
- Which staff handled the most orders and what was the punctuality (how many were early and how many were late) of the orders?
- Which stores held the most quantity?
- Which store generated the most revenue?
- What was the punctuality of the orders of the various stores?

## Data Visualization
This involved using the results of the SQL Queries written to visualize these outcomes and aid informed business decisions being made by the bike retailers. The data visualization was done on Microsoft Power BI and entailed using graphs and charts such as bar chart, column charts, tables etc

## Results/Findings
The results/findings from this project can be summarized as follows;
- Mount Vernon is the city with the most customers with 20, while New York is the state with the most customers with 1,019
- 72% of the overall orders were delivered early (on or before the required date), while 28% of the overall orders were delivered late (after the required date)
- The Trek Domane SLR 9 Disc - 2018 generated the most revenue amongst all the products
- The Trek brand generated the most revenue with $4.6 million
- The Mountain Bikes category generated the most revenue with $2.71 million
- Rowlett Bike store holds the most products with 4,620
- Amongst all our customers Sharyn Hopkins made the highest value of purchases with $34,807.93
- Products from model year 2017 generated the most revenue with $3.2 million
- Baldwin Bikes store generated the most revenue with $5.2 million
- Marcelene Boyer generated the most revenue amongst all the staff with $2.6 million 
- Marcelene Boyer also handled the most orders with 70% of them being shipped early
- Baldwin Bikes store received the most orders (1,093) with 71% of them being early

## Recommendations
The recommendations from this data analysis project are summarized below;
- The bike retailer should look to marketing and opening up new stores in California and Texas to expand its customer base as majority of its customers are from New York
- Set standards for order punctuality e.g order tracking system, better communication with customers for order delivery; as late order deliveries can affect customer patronage and reduce customer loyalty
- Identify areas to improve revenue generated from products of other brands as the Trek brand provides majority of its revenue e.g renegotiating contracts with other brands, increased advertising, discounts, offers promos etc.
- Increase customer loyalty and patronage by seeking feedback on bikes purchased and offering after sales services such as warranties, free repairs, riding lessons etc
- Further breakdown and analyse the 2018 model year products as they generated far less revenue than 2016 and 2017. Identify issues in costing, logistics, pricing, product quality 
 and obtain customer reviews
- Analyse the operations of Rowlett and Santa Cruz bike stores as they generated far less revenue than the Baldwin Bike stores. This could possibly due to the ambience of the stores, quality of products sold, customer service at the stores or the locations of the stores.
- Set standards and performance objectives for staff with regards to order punctuality so as to improve their performance
- Seek reviews from staff to get their feedback on processes and operations in order to identify areas for improvement
