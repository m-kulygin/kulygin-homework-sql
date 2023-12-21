-- Спроектировать базу данных hh (основные таблицы: вакансии, резюме, отклики, специализации)
-- По необходимым столбцам ориентироваться на сайт hh.ru

DROP TABLE IF EXISTS area CASCADE;
DROP TABLE IF EXISTS specialization CASCADE;
DROP TABLE IF EXISTS employer CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS vacancy CASCADE;
DROP TABLE IF EXISTS resume CASCADE;
DROP TABLE IF EXISTS response CASCADE;

CREATE TABLE area
(
  area_id SERIAL PRIMARY KEY,
  area_name TEXT NOT NULL
);

CREATE TABLE specialization
(
  specialization_id SERIAL PRIMARY KEY,
  specialization_name TEXT NOT NULL
);

CREATE TABLE employer
(
  employer_id SERIAL PRIMARY KEY,
  employer_name TEXT NOT NULL
);

CREATE TABLE employee
(
  employee_id SERIAL PRIMARY KEY,
  employee_name TEXT NOT NULL
);

CREATE TABLE vacancy
(
  vacancy_id SERIAL PRIMARY KEY,
  vacancy_name TEXT NOT NULL,
  employer_id INTEGER NOT NULL REFERENCES employer (employer_id),
  area_id INTEGER NOT NULL REFERENCES area (area_id),
  specialization_id INTEGER NOT NULL REFERENCES specialization (specialization_id),
  compensation_from INTEGER,
  compensation_to INTEGER,
  created_at TIMESTAMP
);

CREATE TABLE resume
(
  resume_id SERIAL PRIMARY KEY,
  resume_name TEXT NOT NULL,
  employee_id INTEGER NOT NULL REFERENCES employee (employee_id),
  area_id INTEGER NOT NULL REFERENCES area (area_id),
  specialization_id INTEGER NOT NULL REFERENCES specialization (specialization_id),
  compensation_from INTEGER,
  compensation_to INTEGER,
  created_at TIMESTAMP
);

CREATE TABLE response
(
  response_id SERIAL PRIMARY KEY,
  vacancy_id INTEGER NOT NULL REFERENCES vacancy (vacancy_id),
  resume_id INTEGER NOT NULL REFERENCES resume (resume_id),
  created_at TIMESTAMP
);
