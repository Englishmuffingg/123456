CREATE TABLE raw_sales(
	datesold     Date,
	postcode     INt,
	price        INT,
	propertyType VARCHAR,
	bedrooms     Int
);
ALTER TABLE raw_sales
ADD COLUMN id SERIAL PRIMARY KEY;




--find duplicates
SELECT datesold, price, postcode, bedrooms, propertyType, COUNT(*)
FROM raw_sales
GROUP BY datesold, price, postcode, bedrooms, propertyType
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;


--find invalid value
DELETE FROM raw_sales
WHERE price > (SELECT AVG(price) + 3 * stddev(price) 
               FROM raw_sales) 
OR price < (SELECT AVG(price) - 3 * stddev(price) 
            FROM raw_sales);



--find missing value
SELECT *
FROM raw_sales
WHERE price     IS NULL 
OR bedrooms     IS NULL 
OR datesold     IS NULL
OR propertyType IS NULL
OR postcode     IS NULL;

--delete rows with missing values
DELETE FROM raw_sales
WHERE price     IS NULL 
OR bedrooms     IS NULL 
OR datesold     IS NULL
OR propertyType IS NULL
OR postcode     IS NULL;


--Export the entire raw_sales table
SELECT * 
FROM raw_sales;

