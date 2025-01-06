SELECT TOP (1000) [show_id]
      ,[type]
      ,[title]
      ,[director]
      ,[casts]
      ,[country]
      ,[date_added]
      ,[release_year]
      ,[rating]
      ,[duration]
      ,[listed_in]
      ,[description]
  FROM [Netflix_DB].[dbo].[Netflix_Data]

-- Total Number of Records used in this Dataset  
SELECT COUNT(*) Total_Content FROM Netflix_Data


-- (1) Count the number of Movies vs TV Shows
SELECT type, COUNT(*) Total_Content FROM Netflix_Data
GROUP BY type
ORDER BY COUNT(*)


-- (2) Find the most common rating for movies and TV shows
GO
CREATE VIEW Content_Rating_Rank AS
SELECT 
    type AS Content_Type, 
    rating AS Rating_Category, 
    COUNT(rating) AS Total_Ratings, 
    RANK() OVER (PARTITION BY type ORDER BY COUNT(rating) DESC) AS Type_Rating_Rank
FROM Netflix_Data
GROUP BY type, rating
GO

SELECT * FROM Content_Rating_Rank
WHERE Type_Rating_Rank <= 3


-- (3) List all movies released in a specific year (e.g., 2020)
SELECT
type as Content_Type,
title Movie_Title,
release_year 
FROM Netflix_Data
WHERE   type = 'Movie' AND release_year = 2020 



-- (4) Find the top 5 countries with the most content on Netflix

SELECT TOP 5
country,
COUNT(*) Total_Content 
FROM Netflix_Data
Group by country
Order by 2 desc
-- This Answer would be wrong because of there are some countries that are comma separated in it
--here Number of Orignal Countries
SELECT 
Distinct(COUNT(country)) No_of_Orignal_Countries from Netflix_Data

-- List of Orignal Distinct Countries given in Dataset
SELECT 
Distinct country Orignal_Countries from Netflix_Data

------------- Solution to this Problem------------

-- Here I have made a New _Country column by using string_Split function and applying some triming

SELECT  
	country AS Original_Countries,
    Trim(value) AS New_Country
FROM Netflix_Data
CROSS APPLY STRING_SPLIT(country, ',');


-- List of Distinct New_Countries after spliting and Triming
SELECT  
	 Distinct(Trim(value)) AS New_Country
FROM Netflix_Data
CROSS APPLY STRING_SPLIT(country, ',');
-- Final Solution to this Problem
SELECT 
	TOP 5
    Trim(value) New_Country, 
	COUNT(show_id) Total_Content_By_Country
FROM Netflix_Data
CROSS APPLY STRING_SPLIT(country, ',')
Group by Trim(value) 
ORDER BY COUNT(show_id) DESC


-- (5) Identify the Top 3 longest movie

Select Top 3
title Movie_Title, 
Trim(duration) Movie_Duration_in_Minutes
from Netflix_Data 
where type = 'Movie' 
Order by CAST(LEFT(duration, CHARINDEX(' ', duration) - 1) AS INT) DESC

--6. Find content added in the last 5 years
Select CAST(DATEADD(YEAR,-5,GETDATE()) AS date) Five_Year_Ago_date 

SELECT 
type,
title,
CAST(date_added AS DATE) AS Date_Added   
FROM Netflix_Data
WHERE date_added >= CAST(DATEADD(YEAR,-5,GETDATE()) AS date)
Order by CAST(date_added AS DATE);

--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
-- Method 1
SELECT * FROM Netflix_Data
WHERE director like '%Rajiv Chilaka%'

-- For case director column contains name in Lower case 
SELECT * FROM Netflix_Data
WHERE director COLLATE SQL_Latin1_General_CP1_CI_AS LIKE '%Rajiv Chilaka%'

-- OR
-- Method 2
select *,
value Director
from Netflix_Data
CROSS APPLY string_split(director,',')
Where value = 'Rajiv Chilaka'


--8. List all TV shows with more than 5 seasons

SELECT *
FROM Netflix_Data
WHERE type = 'TV Show'
  AND CAST(LEFT(duration, CHARINDEX(' ', duration) - 1) AS INT) > 5;



--9. Count the number of content items in each genre

Select Trim(value)  Genre , 
Count(*)  Total_Content from Netflix_Data
CROSS APPLY string_split(listed_in,',')
Group by Trim(value)
Order by Count(*) DESC

--10.Find each year and the average numbers of content release in India on netflix. 
--return top 5 year with highest avg content release!

-- This is Total_release_Content_In_India and Number_of_Content_release_year so that One can check answer of this complex solution below
Select 
Trim(value) Country, COUNT(*) Total_release_Content_In_India
from Netflix_Data
CROSS APPLY string_split(country,',')
Where Trim(value) = 'India'
Group by Trim(value)

Select COUNT( DISTINCT
YEAR(CAST(date_added as date))) Number_of_Content_release_year
from Netflix_Data
CROSS APPLY string_split(country,',')
Where Trim(value) = 'India'

GO
CREATE VIEW Average_Content_Per_Year_India AS
Select 
Trim(value) Country, 
YEAR(CAST(date_added as date)) Content_release_year, 
COUNT(*) as Total_Content_release_in_India,
CAST((COUNT(*) * 1.00)/ (Select COUNT( DISTINCT
						YEAR(CAST(date_added as date))) Content_release_year
						from Netflix_Data
						CROSS APPLY string_split(country,',')
						Where Trim(value) = 'India') as decimal(10,2)) Average_Content_Per_year_In_India
from Netflix_Data
CROSS APPLY string_split(country,',')
Where Trim(value) = 'India'
Group by Trim(value), YEAR(CAST(date_added as date))
GO

Select * from Average_Content_Per_Year_India
Order by Total_Content_release_in_India desc

-- For second part of this video
Select  TOP 5 * from Average_Content_Per_Year_India
Order by Average_Content_Per_year_In_India DESC

--11. List all movies that are documentaries
Select * from Netflix_Data
Where listed_in like '%Documentaries%'

--12. Find all content without a director
Select * from Netflix_Data
Where director is NULL

--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

Select * from Netflix_Data
Where type = 'Movie' and casts like '%Salman Khan%' and release_year > (YEAR(CAST(GETDATE() as date)) - 10)


--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

Select TOP 10
TRIM(value) Indian_Actor,
COUNT(TRIM(value)) Appearance_in_Movie
from Netflix_Data
CROSS APPLY string_split(casts,',')
where country like '%India%' and type = 'Movie'
Group by TRIM(value)
Order by COUNT(TRIM(value)) DESC;

--15.
--Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--the description field. Label content containing these keywords as 'Bad' and all other 
--content as 'Good'. Count how many items fall into each category.

WITH Category_table AS
			(SELECT  *,
			CASE WHEN
					description LIKE '%kill%' OR description like '%violence%' then 'Bad_Content'
					ELSE 'Good_Content'
			END Category
			From Netflix_Data
			)
Select Category, COUNT(show_id) Number_Content from Category_table
Group by Category