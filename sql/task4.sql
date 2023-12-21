-- Написать запрос для получения месяца с наибольшим количеством вакансий
-- и месяца с наибольшим количеством резюме
(SELECT 'Vacancy' AS vacancy_or_resume,
        EXTRACT(YEAR FROM created_at) AS year_number,
        EXTRACT(MONTH FROM created_at) AS month_number,
        count(DISTINCT vacancy_id) AS count
 FROM vacancy
 GROUP BY year_number, month_number
 ORDER BY count DESC
 LIMIT 1)
UNION
(SELECT 'Resume' AS vacancy_or_resume,
        EXTRACT(YEAR FROM created_at) AS year_number,
        EXTRACT(MONTH FROM created_at) AS month_number,
        count(DISTINCT resume_id) AS count
 FROM resume
 GROUP BY year_number, month_number
 ORDER BY count DESC
 LIMIT 1);