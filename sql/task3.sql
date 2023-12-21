-- Написать запрос для получения средних значений по регионам (area_id) следующих величин:
-- compensation_from, compensation_to, среднее_арифметическое_from_и_to
SELECT v.area_id,
       AVG(compensation_from) AS avg_from,
       AVG(compensation_to) AS avg_to,
       AVG((compensation_from+compensation_to) / 2) AS avg_from_to
FROM vacancy v
       LEFT JOIN area a ON v.area_id = a.area_id
GROUP BY v.area_id;