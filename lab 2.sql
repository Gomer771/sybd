CREATE DATABASE UniversityDB;
GO

USE UniversityDB;
GO

-- Создаем таблицу факультетов для нормализации
CREATE TABLE FACULTIES (
    faculty_id INT IDENTITY(1,1) PRIMARY KEY,
    faculty_name NVARCHAR(50) NOT NULL
);

-- Создаем таблицу форм обучения
CREATE TABLE STUDY_FORMS (
    form_id INT IDENTITY(1,1) PRIMARY KEY,
    form_name NVARCHAR(20) NOT NULL
);

-- Создаем таблицу групп
CREATE TABLE GROUPS (
    group_id INT IDENTITY(1,1) PRIMARY KEY,
    group_name NVARCHAR(50) NOT NULL,
    course_number INT NOT NULL,
    faculty_id INT NOT NULL,
    form_id INT NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES FACULTIES(faculty_id),
    FOREIGN KEY (form_id) REFERENCES STUDY_FORMS(form_id)
);

-- Создаем таблицу предметов
CREATE TABLE SUBJECTS (
    subject_id INT IDENTITY(1,1) PRIMARY KEY,
    subject_name NVARCHAR(200) NOT NULL,
    hours_count INT NOT NULL,
    control_form NVARCHAR(50)
);

-- Создаем таблицу студентов
CREATE TABLE STUDENTS (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(25) NOT NULL,
    last_name NVARCHAR(25) NOT NULL,
    middle_name NVARCHAR(25),
    birth_date DATE,
    admission_date DATE,
    avg_score FLOAT,
    group_id INT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES GROUPS(group_id)
);

-- Создаем таблицу преподавателей
CREATE TABLE TEACHERS (
    teacher_id INT IDENTITY(1,1) PRIMARY KEY,
    last_name NVARCHAR(25) NOT NULL,
    first_name NVARCHAR(25) NOT NULL,
    middle_name NVARCHAR(25),
    birth_date DATE,
    start_work_date DATE,
    faculty_id INT,
    FOREIGN KEY (faculty_id) REFERENCES FACULTIES(faculty_id)
);

-- Создаем таблицу связи преподавателей и предметов
CREATE TABLE TEACHER_SUBJECTS (
    teacher_id INT NOT NULL,
    subject_id INT NOT NULL,
    hours INT NOT NULL,
    form_id INT NOT NULL,
    course_number INT NOT NULL,
    PRIMARY KEY (teacher_id, subject_id, form_id, course_number),
    FOREIGN KEY (teacher_id) REFERENCES TEACHERS(teacher_id),
    FOREIGN KEY (subject_id) REFERENCES SUBJECTS(subject_id),
    FOREIGN KEY (form_id) REFERENCES STUDY_FORMS(form_id)
);

-- Создаем таблицу учебного плана
CREATE TABLE STUDY_PLANS (
    group_id INT NOT NULL,
    subject_id INT NOT NULL,
    PRIMARY KEY (group_id, subject_id),
    FOREIGN KEY (group_id) REFERENCES GROUPS(group_id),
    FOREIGN KEY (subject_id) REFERENCES SUBJECTS(subject_id)
);

INSERT INTO FACULTIES (faculty_name) VALUES 
(N'ФПМ'),
(N'ФПК');

INSERT INTO STUDY_FORMS (form_name) VALUES 
(N'очная'),
(N'заочная');

-- Заполняем группы
INSERT INTO GROUPS (group_name, course_number, faculty_id, form_id) VALUES 
(N'ФПМ135', 1, 1, 1),
(N'ФПМ235', 2, 1, 1),
(N'ФПМ335', 3, 1, 1),
(N'ФПК201', 2, 2, 2),
(N'ФПК301', 3, 2, 2);

-- Заполняем предметы
INSERT INTO SUBJECTS (subject_name, hours_count, control_form) VALUES 
(N'Математика', 200, N'экзамен'),
(N'Программирование', 120, N'экзамен'),
(N'Базы данных', 100, N'зачет'),
(N'Операционные системы', 130, N'экзамен'),
(N'Теория алгоритмов', 120, N'экзамен'),
(N'Компьютерные сети', 100, N'зачет');

-- Заполняем студентов
INSERT INTO STUDENTS (last_name, first_name, middle_name, birth_date, admission_date, avg_score, group_id) VALUES
(N'Иванов', N'Иван', NULL, '1997-12-25', '2016-09-01', 8.0, 1),
(N'Кузнецов', N'Петр', N'Петрович', '1998-10-12', '2016-09-01', 7.4, 1),
(N'Сидорова', N'Мария', NULL, '1996-09-22', '2015-09-01', 8.8, 2),
(N'Ковалева', N'Анна', N'Петровна', '1997-06-17', '2015-09-01', 9.1, 2),
(N'Петров', N'Сергей', N'Сергеевич', '1995-05-13', '2014-09-01', 8.9, 3),
(N'Баранова', N'Ольга', NULL, '1995-08-14', '2014-09-01', 7.5, 3),
(N'Кириллов', N'Константин', N'Александрович', '1996-10-15', '2016-09-01', 6.9, 4),
(N'Александровский', N'Александр', N'Владимирович', '1994-03-22', '2014-09-01', 8.2, 5);

-- Заполняем преподавателей
INSERT INTO TEACHERS (last_name, first_name, middle_name, birth_date, start_work_date, faculty_id) VALUES
(N'Смирнов', N'Андрей', N'Петрович', '1975-05-20', '2010-09-01', 1),
(N'Козлова', N'Елена', N'Ивановна', '1980-08-15', '2015-03-15', 1),
(N'Смит', N'Джон', NULL, '1978-12-10', '2018-01-10', 2),
(N'Петрова', N'Мария', N'Сергеевна', '1985-10-25', '2019-06-20', 2),
(N'Мюллер', N'Ганс', NULL, '1972-03-30', '2017-08-15', 1),
(N'Васильева', N'Ирина', N'Алексеевна', '1988-10-05', '2020-02-01', 1);

-- Заполняем связь преподавателей и предметов
INSERT INTO TEACHER_SUBJECTS (teacher_id, subject_id, hours, form_id, course_number) VALUES
(1, 1, 150, 1, 1), (1, 2, 120, 1, 2),
(2, 3, 100, 1, 2), (2, 4, 130, 1, 3),
(3, 5, 120, 2, 3), (3, 6, 100, 2, 2),
(4, 1, 200, 2, 1), (4, 3, 100, 2, 2),
(5, 2, 120, 1, 1), (5, 5, 120, 1, 3),
(6, 4, 130, 1, 2), (6, 6, 100, 1, 3);

-- Заполняем учебный план
INSERT INTO STUDY_PLANS (group_id, subject_id) VALUES
(1, 1), (1, 2),
(2, 3), (2, 4),
(3, 5), (3, 6),
(4, 1), (4, 3),
(5, 2), (5, 5);

UPDATE GROUPS SET group_name = N'ФПМ134' WHERE group_id = 1;

DELETE FROM STUDY_PLANS WHERE group_id IN (SELECT group_id FROM GROUPS WHERE group_name = N'ФПМ135');
DELETE FROM GROUPS WHERE group_name = N'ФПМ135';

UPDATE SUBJECTS SET hours_count = hours_count + 30 
WHERE subject_name IN (N'Теория алгоритмов', N'Компьютерные сети');



-- 1
SELECT last_name
FROM STUDENTS
WHERE last_name LIKE N'%б%' OR last_name LIKE N'%о%';

-- 2
SELECT *
FROM STUDENTS
WHERE last_name LIKE N'К%' AND middle_name IS NULL;

-- 3
SELECT *
FROM STUDENTS
WHERE LEN(last_name) >= 8;

-- 4
SELECT *
FROM STUDENTS
WHERE LEN(last_name) <> 7 AND last_name LIKE N'%а%';

-- 5
SELECT s.*
FROM STUDENTS s
JOIN GROUPS g ON s.group_id = g.group_id
JOIN FACULTIES f ON g.faculty_id = f.faculty_id
JOIN STUDY_FORMS sf ON g.form_id = sf.form_id
WHERE f.faculty_name = N'ФПМ' AND sf.form_name = N'очная' AND g.course_number IN (1, 2)
ORDER BY s.middle_name;

-- 6. Найти всех студентов учащихся на ФПК заочном со средним балом успеваемости больше 6, отсортировать результаты по оценке в убывающем порядке
SELECT s.*
FROM STUDENTS s
JOIN GROUPS g ON s.group_id = g.group_id
JOIN FACULTIES f ON g.faculty_id = f.faculty_id
JOIN STUDY_FORMS sf ON g.form_id = sf.form_id
WHERE f.faculty_name = N'ФПК' AND sf.form_name = N'заочная' AND s.avg_score > 6
ORDER BY s.avg_score DESC;

-- 7. ИСПРАВЛЕНО: Вывести список всех преподавателей, которые работают на ФПК отсортировать по алфавиту фамилии в пределах каждой формы обучения
SELECT sf.form_name, t.*
FROM TEACHERS t
JOIN FACULTIES f ON t.faculty_id = f.faculty_id
JOIN TEACHER_SUBJECTS ts ON t.teacher_id = ts.teacher_id
JOIN STUDY_FORMS sf ON ts.form_id = sf.form_id
WHERE f.faculty_name = N'ФПК'
ORDER BY sf.form_name, t.last_name;

-- 8. Вывести список всех преподавателей, которые работают на ФПМ, первом курсе и читают дисциплины более 100 часов
SELECT DISTINCT t.*
FROM TEACHERS t
JOIN FACULTIES f ON t.faculty_id = f.faculty_id
JOIN TEACHER_SUBJECTS ts ON t.teacher_id = ts.teacher_id
WHERE f.faculty_name = N'ФПМ' AND ts.course_number = 1 AND ts.hours > 100;

-- 9. Вывести список преподавателей иностранцев, работающих в университете более трех лет на текущий момент
SELECT *, DATEDIFF(YEAR, start_work_date, GETDATE()) as work_experience
FROM TEACHERS
WHERE middle_name IS NULL AND DATEDIFF(YEAR, start_work_date, GETDATE()) > 3;

-- 10. Вывести информацию о дисциплинах, читаемых для студентов третьего курса ФПМ
SELECT DISTINCT s.*
FROM SUBJECTS s
JOIN STUDY_PLANS sp ON s.subject_id = sp.subject_id
JOIN GROUPS g ON sp.group_id = g.group_id
JOIN FACULTIES f ON g.faculty_id = f.faculty_id
WHERE f.faculty_name = N'ФПМ' AND g.course_number = 3;

-- 11. Вывести информацию о дисциплинах (курс, форма обучения, Фио преподавателя), читаемых на ФПК, число часов по которым больше 100
SELECT ts.course_number, sf.form_name, 
       t.last_name + ' ' + t.first_name + ISNULL(' ' + t.middle_name, '') as teacher_fio,
       s.subject_name, ts.hours
FROM TEACHER_SUBJECTS ts
JOIN TEACHERS t ON ts.teacher_id = t.teacher_id
JOIN SUBJECTS s ON ts.subject_id = s.subject_id
JOIN STUDY_FORMS sf ON ts.form_id = sf.form_id
JOIN FACULTIES f ON t.faculty_id = f.faculty_id
WHERE f.faculty_name = N'ФПК' AND ts.hours > 100;

-- 12. Вывести информацию о дисциплинах (факультет, курс, форма обучения, Фио преподавателя), которые ведут преподаватели иностранцы
SELECT f.faculty_name, ts.course_number, sf.form_name,
       t.last_name + ' ' + t.first_name + ISNULL(' ' + t.middle_name, '') as teacher_fio,
       s.subject_name
FROM TEACHER_SUBJECTS ts
JOIN TEACHERS t ON ts.teacher_id = t.teacher_id
JOIN SUBJECTS s ON ts.subject_id = s.subject_id
JOIN STUDY_FORMS sf ON ts.form_id = sf.form_id
JOIN FACULTIES f ON t.faculty_id = f.faculty_id
WHERE t.middle_name IS NULL;

-- 13. Вывести список преподавателей старше 30 лет на начало текущего года
SELECT *, DATEDIFF(YEAR, birth_date, DATEFROMPARTS(YEAR(GETDATE()), 1, 1)) as age
FROM TEACHERS
WHERE DATEDIFF(YEAR, birth_date, DATEFROMPARTS(YEAR(GETDATE()), 1, 1)) > 30;

-- 14. Вывести список преподавателей, от 35 до 40 лет на настоящий момент, отсортировать их по алфавиту фамилии
SELECT *, DATEDIFF(YEAR, birth_date, GETDATE()) as age
FROM TEACHERS
WHERE DATEDIFF(YEAR, birth_date, GETDATE()) BETWEEN 35 AND 40
ORDER BY last_name;

-- 15. Вывести список преподавателей, день рождения у которых в октябре, Вывести в порядке возрастания даты рождения
SELECT *, DAY(birth_date) as birth_day
FROM TEACHERS
WHERE MONTH(birth_date) = 10
ORDER BY birth_date ASC;