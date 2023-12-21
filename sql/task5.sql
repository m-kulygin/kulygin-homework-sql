-- Написать запрос для получения id и title вакансий,
-- которые собрали больше 5 откликов в первую неделю после публикации
SELECT r.vacancy_id,
       v.vacancy_name,
       count(DISTINCT response_id) AS one_week_response_count
FROM response r
       JOIN vacancy v ON r.vacancy_id = v.vacancy_id
WHERE (r.created_at - v.created_at) <= '1 week'
GROUP BY r.vacancy_id, v.vacancy_name
HAVING count(DISTINCT response_id) >= 5
ORDER BY vacancy_id;