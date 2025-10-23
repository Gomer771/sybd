
CREATE TABLE GROUPS (
    GroupID VARCHAR(10) PRIMARY KEY,
    GroupName VARCHAR(50),
    Course INTEGER
);

CREATE TABLE SUBJECTS (
    SubjectID INTEGER PRIMARY KEY,
    SubjectName VARCHAR(100),
    Hours INTEGER
);

CREATE TABLE STUDENTS (
    StudentID INTEGER PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    MiddleName VARCHAR(50),
    BirthDate DATE,
    GroupID VARCHAR(10),
    FOREIGN KEY (GroupID) REFERENCES GROUPS(GroupID)
);

CREATE TABLE [PLAN] (
    GroupID VARCHAR(10),
    SubjectID INTEGER,
    PRIMARY KEY (GroupID, SubjectID),
    FOREIGN KEY (GroupID) REFERENCES GROUPS(GroupID),
    FOREIGN KEY (SubjectID) REFERENCES SUBJECTS(SubjectID)
);

INSERT INTO GROUPS VALUES 
('PO135', 'PO135', 1),
('PO235', 'PO235', 2),
('PO335', 'PO335', 3);

INSERT INTO SUBJECTS VALUES 
(1, 'Physics', 200),
(2, 'Mathematics', 120),
(3, 'Fundamentals of Algorithmization', 70),
(4, 'Database Design', 130),
(5, 'Visual Programming Tools', 90),
(6, 'Object-Oriented Programming', 70);

INSERT INTO STUDENTS VALUES 
(1, 'P', 'Fedorenko', 'R.', '1997-12-25', 'PO135'),
(2, 'O', 'Zingel', NULL, '1985-12-25', 'PO135'),
(3, 'N', 'Savitskayan', NULL, '1987-09-22', 'PO235'),
(4, 'M', 'Kovalchuk', 'E.', '1992-06-17', 'PO235'),
(5, 'T', 'Kovrigo', 'R.', '1992-05-13', 'PO335'),
(6, 'N', 'Sharapo', NULL, '1992-08-14', 'PO335');

INSERT INTO [PLAN] VALUES 
('PO135', 1), ('PO135', 2),
('PO235', 3), ('PO235', 4),
('PO335', 5), ('PO335', 6);


INSERT INTO GROUPS (GroupID, GroupName, Course)
VALUES ('134', '134', 1);

UPDATE STUDENTS
SET GroupID = '134'
WHERE GroupID = 'PO135';


DELETE FROM [PLAN]
WHERE GroupID = 'PO135';

DELETE FROM GROUPS
WHERE GroupID = 'PO135';


UPDATE SUBJECTS
SET Hours = Hours + 30
WHERE SubjectName IN ('Visual Programming Tools', 'Object-Oriented Programming','Physics','Mathematics','Fundamentals of Algorithmization','Database Design');

ALTER TABLE SUBJECTS
ADD AssessmentType VARCHAR(20);

UPDATE SUBJECTS
SET AssessmentType = CASE 
    WHEN SubjectName = 'Fundamentals of Algorithmization' THEN 'Pass/Fail'
    ELSE 'Exam'
END;

ALTER TABLE STUDENTS
DROP COLUMN MiddleName;


SELECT * FROM STUDENTS
SELECT * FROM GROUPS
SELECT * FROM [PLAN]
SELECT * FROM SUBJECTS