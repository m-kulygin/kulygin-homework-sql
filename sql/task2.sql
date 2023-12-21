-- Заполнить базу данных тестовыми данными (порядка 10к вакансий и 100к резюме)
WITH area_data(id, title) AS (SELECT generate_series(1, 80) AS id,
                                     md5(random()::text) AS title)
INSERT
INTO area(area_name)
SELECT title
FROM area_data;

WITH specialization_data(id, title) AS (SELECT generate_series(1, 20) AS id,
                                               md5(random()::text) AS title)
INSERT
INTO specialization(specialization_name)
SELECT title
FROM specialization_data;

WITH employer_data(id, title) AS (SELECT generate_series(1, 1000) AS id,
                                         md5(random()::text) AS title)
INSERT
INTO employer(employer_name)
SELECT title
FROM employer_data;

WITH employee_data(id, title) AS (SELECT generate_series(1, 10000) AS id,
                                         md5(random()::text) AS title)
INSERT
INTO employee(employee_name)
SELECT title
FROM employee_data;

WITH vacancy_data(vacancy_id, title, employer_id, area_id, specialization_id, salary, created_at)
       AS (SELECT generate_series(1, 10000) AS vacancy_id,
                  md5(random()::text) AS title,
                  round((random() * 999)::int, 0) + 1 AS employer_id,
                  round((random() * 79)::int, 0) + 1 AS area_id,
                  round((random() * 19)::int, 0) + 1 AS specialization_id,
                  round((random() * 100000)::int, -3) AS salary,
                  TIMESTAMP '2023-01-01 00:00:00' +
                  random() * (now() - TIMESTAMP '2023-01-01 00:00:00') AS created_at)
INSERT
INTO vacancy(vacancy_name, employer_id, area_id, specialization_id,
             compensation_from, compensation_to, created_at)
SELECT title AS vacancy_name,
       employer_id AS employer_id,
       area_id AS area_id,
       specialization_id AS specialization_id,
       salary AS compensation_from,
       salary + 10000 AS compensation_to,
       created_at AS created_at
FROM vacancy_data;

WITH resume_data(resume_id, title, employee_id, area_id, specialization_id, salary, created_at)
       AS (SELECT generate_series(1, 100000) AS resume_id,
                  md5(random()::text) AS title,
                  round((random() * 9999)::int, 0) + 1 AS employee_id,
                  round((random() * 79)::int, 0) + 1 AS area_id,
                  round((random() * 19)::int, 0) + 1 AS specialization_id,
                  round((random() * 100000)::int, -3) AS salary,
                  TIMESTAMP '2023-01-01 00:00:00' +
                  random() * (now() - TIMESTAMP '2023-01-01 00:00:00') AS created_at)
INSERT
INTO resume(resume_name, employee_id, area_id, specialization_id,
            compensation_from, compensation_to, created_at)
SELECT title AS resume_name,
       employee_id AS employee_id,
       area_id AS area_id,
       specialization_id AS specialization_id,
       salary AS compensation_from,
       salary + 10000 AS compensation_to,
       created_at AS created_at
FROM resume_data;

WITH response_data(response_id, vacancy_id, resume_id)
       AS (SELECT generate_series(1, 100000) AS response_id,
                  round((random() * 9999)::int, 0) + 1 AS vacancy_id,
                  round((random() * 99999)::int, 0) + 1 AS resume_id)
INSERT
INTO response(vacancy_id, resume_id, created_at)
SELECT response_data.vacancy_id AS vacancy_id,
       response_data.resume_id AS resume_id,
       v.created_at + floor(random() * 14) * INTERVAL '1 day' AS created_at
FROM response_data
       INNER JOIN vacancy v ON response_data.vacancy_id = v.vacancy_id;