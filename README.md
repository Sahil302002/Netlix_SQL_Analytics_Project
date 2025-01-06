# Netlix_SQL_Analytics_Project

![logo](https://github.com/user-attachments/assets/dcc1a729-024d-4498-add9-37eeabe1dfce)

This project analyzes Netflix's movies and TV shows dataset using SQL to uncover valuable insights. It focuses on understanding the distribution of content types, identifying popular ratings, exploring trends in release years and countries, and categorizing content based on keywords. Key findings reveal that movies dominate the platform, India and the USA are leading content producers, and most recent additions reflect Netflix’s global expansion. 

The project highlights advanced SQL techniques like aggregation, window functions, string manipulation, and data categorization to solve business problems and extract actionable insights from real-world data.

## **Project Overview**

This project involves analyzing Netflix's dataset to answer various business queries, demonstrate SQL skills in SQL SERVER MANAGEMENT STUDIO(SSMS), and present findings in a structured format.

Key highlights:

- Analysis of **Movies vs. TV Shows** distribution.
- Exploration of **content ratings**, release years, and durations.
- Categorization of content by genres, directors, actors, and countries.
- Insightful categorization of content based on keywords like 'kill' and 'violence.'

---

## **Objectives**

- Analyze the distribution of content types (Movies vs. TV Shows).
- Identify the most common ratings for each type of content.
- List all movies and TV shows by specific criteria like year, country, and genre.
- Detect top-performing countries, longest movies, and content added recently.
- Classify content into categories based on keywords for better insights.

---

## **Dataset**

The dataset contains 8,807 records and was sourced from Kaggle.

Dataset I used in this Project <a href = "netflix_titles.csv">Netflix_CSV Dataset</a>

Key columns:

- **show_id**: Unique identifier for each show.
- **type**: Content type (Movie or TV Show).
- **title**: Title of the content.
- **director**: Director(s) of the content.
- **casts**: Cast members.
- **country**: Countries where the content was produced.
- **date_added**: When the content was added to Netflix.
- **release_year**: Year of release.
- **rating**: Audience rating.
- **duration**: Duration (minutes for movies or seasons for TV shows).
- **listed_in**: Categories/Genres.
- **description**: Short synopsis of the content.

---

## **SQL Queries and Techniques**

### **Table Creation**

```sql
sql
Copy code
CREATE TABLE NETFLIX (
    show_id VARCHAR(7),
    type VARCHAR(20),
    title VARCHAR(150),
    director VARCHAR(250),
    casts VARCHAR(1000),
    country VARCHAR(400),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(20),
    listed_in VARCHAR(50),
    description VARCHAR(300)
);

```

## **SQL Functions and Concepts Used**

- **Data Aggregation**: `COUNT()`, `GROUP BY`.
- **String Operations**: `TRIM()`, `STRING_SPLIT()`.
- **Conditional Logic**: `CASE`.
- **Window Functions**: `RANK()`.
- **Date Functions**: `DATEADD()`, `CAST()`.
- **Views**: Used for reusable queries.
- **Cross Apply**: For handling complex string operations.

Link of SQL which I created in this Project
<a href ="Netlix_SQL_Query_Script.sql">Netflix SQL QUERY SCROPT</a>

This is Pdf Linki of SQL Query along with screenshot of Result 

---

## **Challenges and Learnings**

- Extracting insights from unstructured fields like `country` and `listed_in` using `STRING_SPLIT`.
- Ranking ratings and classifying content based on specific criteria.
- Handling missing values and ensuring accurate computations.

---

## **Findings and Insights**

1. Movies dominate the platform compared to TV Shows.
2. The most common content ratings vary by content type.
3. India and the USA are among the top content-producing countries.
4. Most content has been added recently, reflecting Netflix’s expansion strategy.

---

## **Conclusion**

This project showcases advanced SQL skills, including querying, aggregation, and string manipulation, applied to real-world data. It highlights the ability to derive actionable insights and solve complex business problems.
