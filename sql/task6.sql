-- Создать необходимые индексы (обосновать выбор столбцов)

-- Для таблиц area, specialization, employer, employee - индексы бессмысленны,
-- т.к. в данной работе эти таблицы очень просты

-- Для vacancy:
-- Индекс для поиска вакансий по интервалу зарплат
CREATE INDEX vacancy_salary_index ON vacancy (compensation_from, compensation_to);
-- Индекс для поиска новейших вакансий в заданном регионе
CREATE INDEX vacancy_latest_in_area_index ON vacancy (area_id, created_at DESC);

-- Для resume:
-- Индекс для поиска резюме по интервалу зарплат
CREATE INDEX resume_salary_index ON resume (compensation_from, compensation_to);
-- Индекс для поиска резюме интересующей специализации в заданном регионе
CREATE INDEX resume_spec_in_area_index ON resume (area_id, specialization_id);

-- Для response:
-- Индекс для поиска последних откликов с заданным резюме
CREATE INDEX response_latest_resume_index ON response (resume_id, created_at);
-- Индекс для поиска последних откликов с заданной вакансией
CREATE INDEX response_latest_vacancy_index ON response (vacancy_id, created_at);
