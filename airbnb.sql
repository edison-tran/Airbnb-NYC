-- Average Price of Top 5 Neighbourhoods 
WITH eligible_listings AS (
    SELECT *
    FROM [dbo].[AB_NYC_2019$]
    WHERE number_of_reviews >= 10
    AND last_review >= '2019-07-01'
)
SELECT TOP 5 neighbourhood,
       ROUND(AVG(price), 2) AS avg_price
FROM eligible_listings
GROUP BY neighbourhood
ORDER BY avg_price DESC

-- Determining Prices of Hosts With Multiple Listings
SELECT host_id,
       host_name,
       COUNT(DISTINCT neighbourhood) AS num_neighbourhoods,
       MAX(price) AS max_price,
       MIN(price) AS min_price,
       MAX(price) - MIN(price) AS price_difference
FROM [dbo].[AB_NYC_2019$] 
GROUP BY host_id, host_name
HAVING COUNT(DISTINCT neighbourhood) > 1
ORDER BY price_difference DESC

--Most Expensive Listings In Each Neighbourhood
SELECT neighbourhood,
       id,
       name,
       price,
       rank
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY neighbourhood ORDER BY price DESC) AS rank
    FROM [dbo].[AB_NYC_2019$]
) t
WHERE rank <= 3
ORDER BY neighbourhood, rank

-- Determining Which Month Had The Most Reviews In Each Neighbourhood
WITH monthly_reviews AS (
    SELECT neighbourhood,
           MONTH(last_review) AS month,
           COUNT(*) AS review_count
    FROM [dbo].[AB_NYC_2019$] 
    WHERE last_review IS NOT NULL
    GROUP BY neighbourhood, MONTH(last_review)
),
max_reviews AS (
    SELECT neighbourhood,
           MAX(review_count) AS max_count
    FROM monthly_reviews
    GROUP BY neighbourhood
)
SELECT m.neighbourhood,
       m.month,
       m.review_count
FROM monthly_reviews m
JOIN max_reviews mr ON m.neighbourhood = mr.neighbourhood AND m.review_count = mr.max_count
ORDER BY m.review_count DESC


-- Determining Which Listings Are In the Top 10% Of Prices In Terms Of Room Type
WITH room_type_prices AS (
    SELECT room_type,
           id,
           name,
           price,
           ROW_NUMBER() OVER (PARTITION BY room_type ORDER BY price DESC) AS rn,
           COUNT(*) OVER (PARTITION BY room_type) AS total
    FROM [dbo].[AB_NYC_2019$] 
)
SELECT room_type,
       id,
       name,
       price
FROM room_type_prices
WHERE rn <= 0.1 * total
ORDER BY room_type, price DESC

-- Top Neighbourhoods With The Highest Average Reviews Per Month In The Past 6 Months
SELECT TOP 10 neighbourhood,
       ROUND(AVG(reviews_per_month), 2) AS avg_reviews,
       COUNT(*) AS num_listings
FROM [dbo].[AB_NYC_2019$] 
WHERE last_review >= '2019-07-01' AND last_review IS NOT NULL
GROUP BY neighbourhood
HAVING COUNT(*) > 5
ORDER BY avg_reviews DESC

--Determining Popular Neighbourhoods With High Listings
WITH high_demand_neighborhoods AS (
    SELECT neighbourhood
    FROM [dbo].[AB_NYC_2019$] 
    GROUP BY neighbourhood
    HAVING AVG(availability_365) < 100
)
SELECT TOP 25 h.neighbourhood,
       a.host_name,
       COUNT(a.id) AS total_listings
FROM [dbo].[AB_NYC_2019$]  a
JOIN high_demand_neighborhoods h ON a.neighbourhood = h.neighbourhood
GROUP BY h.neighbourhood, a.host_name
ORDER BY total_listings DESC

--Determining Which Neighbourhood Accumulated The Largest Price Increase
WITH yearly_prices AS (
    SELECT neighbourhood,
           YEAR(last_review) AS review_year,
           ROUND(AVG(price), 2) AS avg_price
    FROM [dbo].[AB_NYC_2019$] 
    WHERE YEAR (last_review) IN (2018, 2019)
    GROUP BY neighbourhood, YEAR(last_review) 
),
price_changes AS (
    SELECT neighbourhood,
           MAX(CASE WHEN review_year = 2019 THEN avg_price END) - 
           MAX(CASE WHEN review_year = 2018 THEN avg_price END) AS price_increase
    FROM yearly_prices
    GROUP BY neighbourhood
)
SELECT neighbourhood,
       price_increase
FROM price_changes
WHERE price_increase IS NOT NULL
ORDER BY price_increase DESC