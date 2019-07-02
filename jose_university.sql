USE university_of_jose;


INSERT INTO Students(Student_Name,Student_Email,Student_Username,Student_password)
Values("Jon",'jon@email.com','jonder','jod');
INSERT INTO Students(Student_Name,Student_Email,Student_Username,Student_password)
Values("anna",'ana@email.com','pony','ahri');
INSERT INTO Students(Student_Name,Student_Email,Student_Username,Student_password)
Values("ben",'ben@email.com','bender','bens');
INSERT INTO Students(Student_Name,Student_Email,Student_Username,Student_password)
Values("lauta",'letee@email.com','lace','loose');

INSERT INTO professors(professors_name,professors_username,professors_password,professors_students_ID)
Values("james",'jackson','jest',2);
INSERT INTO professors(professors_name,professors_username,professors_password,professors_students_ID)
Values("Jason",'Jet','jot',4);
INSERT INTO professors(professors_name,professors_username,professors_password,professors_students_ID)
Values("harley",'dester','dunk',3);
INSERT INTO professors(professors_name,professors_username,professors_password,professors_students_ID)
Values("david",'yaker','hasert',1);

INSERT INTO courses(Course_Student_ID,Course_Name,School_Subject,course_grade,course_hours)
VALUES(1,'Algebra','Math','D',2);
INSERT INTO courses(Course_Student_ID,Course_Name,School_Subject,course_grade,course_hours)
VALUES(2,'English 101','English','B',4);
INSERT INTO courses(Course_Student_ID,Course_Name,School_Subject,course_grade,course_hours)
VALUES(2,'Geometry','Math','C',3);
INSERT INTO courses(Course_Student_ID,Course_Name,School_Subject,course_grade,course_hours)
VALUES(3,'Reading 101','Reading','F',2);
INSERT INTO courses(Course_Student_ID,Course_Name,School_Subject,course_grade,course_hours)
VALUES(4,'Java','Computer Science','A',4);


INSERT INTO grades(grade_Point_Average,current_grade,grade_student_ID,grade_togradepoint)
Values(2.75, 'D', 1, 1.0);
INSERT INTO grades(grade_Point_Average,current_grade,grade_student_ID,grade_togradepoint)
Values(3.42, 'B', 2, 3.0);
INSERT INTO grades(grade_Point_Average,current_grade,grade_student_ID,grade_togradepoint)
Values(2.32, 'C', 2, 2.0);
INSERT INTO grades(grade_Point_Average,current_grade,grade_student_ID,grade_togradepoint)
Values(2.75, 'F', 3, 0.0);
INSERT INTO grades(grade_Point_Average,current_grade,grade_student_ID,grade_togradepoint)
Values(2.75, 'A', 4, 4.0);

Select * from students;
Select * from grades;
Select * from professors;
Select * from courses;

/******** was duplicated by accident so i deleted and reinserted grades and courses***********/
SET SQL_SAFE_UPDATES=0;
delete from grades;

SET FOREIGN_KEY_CHECKS=0;
delete from courses
where (course_hours IS NULL OR course_hours = 0);
SET FOREIGN_KEY_CHECKS=1;

/*******  The average grade given by each professor *******/ 
SELECT Student_Username,current_grade,professors_name
FROM students t
JOIN grades g
ON  g.grade_student_ID = t.Students_ID
JOIN professors p
ON p.professors_students_ID = t.Students_ID;

/******* top grades for each student*********/

SELECT Student_Username,current_grade
FROM students t
JOIN grades g
ON  g.grade_student_ID = t.Students_ID
ORDER BY g.current_grade ASC;

/********* Group students by the courses that they are enrolled in *****************/

Select Student_Name,Course_Name,School_Subject
FROM students t
JOIN courses c
ON  c.Course_Student_ID = t.Students_ID
GROUP BY Course_Name;

/***********************Create a summary report of courses and their average grades,*********************************/
/**********sorted by the most challenging course (course with the lowest average grade) to the easiest course********/

Select Student_Username, Course_Name, current_grade, grade_togradepoint,course_hours,
 SUM(course_hours *grade_togradepoint) / SUM(course_hours) AS Current_GPA
FROM students s
Join grades g
ON  g.grade_student_ID = s.Students_ID
Join courses c
ON c.Course_Student_ID = s.Students_ID
Group by g.current_grade
ORDER by g.current_grade DESC;

/***************Finding which student and professor have the most courses in common************/

SELECT Student_Name,professors_name,Course_Name
FROM students s
JOIN professors p
ON  p.professors_students_ID = s.Students_ID
JOIN courses c
ON c.Course_Student_ID = s.Students_ID
group by Course_Name;