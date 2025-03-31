# Airbnb NYC 2019 Analysis
**Tools Used: Excel, MS SQL Server, Tableau**

[Dataset Used](https://www.kaggle.com/datasets/dgomonov/new-york-city-airbnb-open-data)

[Tableau Visualization](https://public.tableau.com/app/profile/edison.tran/viz/AirbnbDashboard1_17433623241180/Dashboard1)

[Tableau Visualization](https://public.tableau.com/app/profile/edison.tran/viz/AirbnbDashboard2_17433623502500/Dashboard2)

[Tableau Visualization](https://public.tableau.com/app/profile/edison.tran/viz/AirbnbDashboard3_17433623677100/Dashboard3)

## Introduction
Offering an alternative to conventional hotels, Airbnb has become a key platform for short-term rentals, connecting hosts and 
guests worldwide. This project analyzes a dataset of Airbnb listings exclusively from New York City in 2019, a year of 
notable activity in one of the platform’s most vibrant and competitive markets. By examining factors such as location, 
property type, host attributes, and number of reviews within this specific urban context, we uncover what drives 
rental prices within this period. These insights are valuable for hosts seeking to set competitive prices and for guests 
looking for the best value in New York City’s diverse accommodation landscape.



## Motivation and Objective
Pricing on Airbnb is a difficult task, influenced by numerous variables that challenge both hosts and guests. Hosts need to optimize rates to boost occupancy and revenue, while guests want to ensure they’re getting fair value. This project seeks to answer key pricing questions by diving deep into New York City’s Airbnb market:

Location Impact: How do neighborhood traits and proximity to attractions determine pricing?

Property Features: What influence do property type and location convenience have on rates?

Host Attributes: How did host experience, response rates, and number of reviews affect pricing?

Seasonal Trends: How did pricing shift across different times of the year?


## Approach
### Data Extraction & Transformation (SQL)
Data Querying:
Grouping listings by boroughs (e.g., Manhattan, Brooklyn), property types, and price of listings.

Arithmetic Functions and Filters:
Calculating metrics like average prices and number of reviews across these categories.

Aggregatation of Various Data:
Joining listing data with calendar and review datasets to enrich the analysis.

Advanced SQL Functions: 
Applying window functions to track trends and rank listings within neighborhoods.


### Visualization (Tableau)
Geographical Maps: Showing price distributions across New York City’s boroughs.

Bar Charts: Comparing average prices by property type or host category.

Dual Axis Charts: Illustrate trends that variables have with one another.

Dashboards: Combining visuals with filters for boroughs, time periods, or prices.


## Results
Location Premium: Manhattan listings increased by 1.6 to 2.2 times higher than outer boroughs like the Bronx.

Review Impact: Number of reviews between 0-10 were 29% less expensive than reviews with over 100.

Seasonal Fluctuations: Prices were relatively low during Spring and Summer months, but increased for Winter months.

Listing Type: Shared rooms were nearly 2 times less expensive than entire homes or apartments.


## Conclusion
Through utilizing tools from SQL and Tableau, crucial insights are brought forward within this location-specific dataset.
By dissecting the drivers of Airbnb pricing in New York City during 2019, hosts and guests are provided with many
tools to navigate the marketplace effectively. Hosts can refine pricing with factors such as location and room type,
while guests can better assess value of their stay. As the sharing economy grows, such focused, data-driven 
analyses will remain vital for strategic decision-making.

