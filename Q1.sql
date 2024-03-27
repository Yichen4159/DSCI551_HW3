-- Q1.sql

USE dsci551;

-- a.Find out which courses were offered in Spring 2023 but not in Fall 2023. Report course number and title
SELECT number, title
FROM Course
WHERE semester = 'Spring 2023'
AND number NOT IN (SELECT number FROM Course WHERE semester = 'Fall 2023');

-- b.Find out titles of which courses in Fall 2023 contain “data” and are taught by Professor “John Smith”.
SELECT c.title
FROM Course c
JOIN Teach t ON c.number = t.cno
JOIN Instructor i ON t.rid = i.id
WHERE c.semester = 'Fall 2023'
AND c.title LIKE '%data%'
AND i.name = 'John Smith';

-- c.Find out which students have taken both DSCI 351 and DSCI 250 (both are course numbers). Report student id and name
SELECT s.id, s.name
FROM Student s
WHERE EXISTS (SELECT 1 FROM Take WHERE sid = s.id AND cno = 'DSCI 351')
AND EXISTS (SELECT 1 FROM Take WHERE sid = s.id AND cno = 'DSCI 250');

-- d.Find out which students have taken DSCI 351 but not DSCI 250. Report student id and name.
SELECT s.id, s.name
FROM Student s
WHERE EXISTS (SELECT 1 FROM Take WHERE sid = s.id AND cno = 'DSCI 351')
AND NOT EXISTS (SELECT 1 FROM Take WHERE sid = s.id AND cno = 'DSCI 250');

-- e.Find out which students did not take any courses in Fall 2023.
SELECT s.id, s.name
FROM Student s
WHERE NOT EXISTS (SELECT 1 FROM Take WHERE sid = s.id AND semester = 'Fall 2023');

-- f.Find out which instructors teach the largest number of courses in Fall 2023. Report instructor id and name
SELECT i.id, i.name, COUNT(t.cno) as course_count
FROM Instructor i
JOIN Teach t ON i.id = t.rid
WHERE t.semester = 'Fall 2023'
GROUP BY i.id, i.name
ORDER BY course_count DESC
LIMIT 1;

-- g.Find out which instructors teach only one course in Fall 2023 without using aggregate functions in SQL. Report instructor names and course numbers.
SELECT i.name, t1.cno
FROM Teach t1
JOIN Instructor i ON t1.rid = i.id
WHERE t1.semester = 'Fall 2023'
AND NOT EXISTS (SELECT 1 FROM Teach t2 WHERE t2.rid = t1.rid AND t2.cno != t1.cno AND t2.semester = 'Fall 2023');

-- h.Find out for each instructor, the average number of students in his/her courses offered in Fall 2023
SELECT t.rid as instructor_id, i.name, AVG(student_count) as avg_student_count
FROM Teach t
JOIN Instructor i ON t.rid = i.id
JOIN (SELECT cno, COUNT(sid) as student_count FROM Take WHERE semester = 'Fall 2023' GROUP BY cno) subq
ON t.cno = subq.cno
WHERE t.semester = 'Fall 2023'
GROUP BY t.rid, i.name;

-- i.Find out which courses offered in Fall 2023 have only one TA. Report the course titles
SELECT c.title
FROM Course c
WHERE c.semester = 'Fall 2023'
AND c.number IN (SELECT a.cno FROM Assist a WHERE a.semester = 'Fall 2023' GROUP BY a.cno HAVING COUNT(a.sid) = 1);

-- j.Find out which TAs work for more than 15 hours a week and take 3 courses in Fall 2023. Report names of such TAs
SELECT s.name
FROM TA ta
JOIN Student s ON ta.sid = s.id
WHERE ta.hours > 15
AND (SELECT COUNT(*) FROM Take WHERE sid = ta.sid AND semester = 'Fall 2023') = 3;
