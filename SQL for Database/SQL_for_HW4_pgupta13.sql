 
                                                      /* Homework Assignment 3 for CS 550
                                                    By Prachi Gupta, G01025257, user: pgupta13 */


--1.
select s.s_name,s.MAJOR from student s,enrollment e  
where s.SSN=e.STUDENT_SSN group by s.major,s.s_name having count(e.class_no) <=4 order by s.major;
--2
SELECT ssn, s_name, COUNT(DISTINCT c_no)
FROM student s, transcript e
WHERE s.ssn = e.student_ssn (+)
GROUP BY ssn, s_name
ORDER BY COUNT (DISTINCT c_no), ssn;
--3
select d.chair_ssn from department d where d.d_name like 'I%';

--4
select count(*) from student where major is not null;

--5
SELECT s.ssn, s.s_name,sum(C.units)
FROM student s, enrollment e, class cl, course c
WHERE (s.ssn = e.student_ssn(+)  AND e.CLASS_NO = cl.CLASS_NO(+) AND cl.c_no = c.c_no(+)AND c.D_CODE=cl.D_CODE ) 
group by s.ssn,s.s_name having sum(C.units) >9  ;

--6
select distinct (select count(*) from student s, transcript t
where s.ssn= t.STUDENT_SSN AND  t.GRADE <> 'A' )/(select count( t1.student_ssn) from  transcript t1) AS percent 
from student s2, transcript t2;

--7
select c.D_CODE,c.C_NO , sum(decode(t.grade,'A',1,0) ) AS Grade_A, 
sum(decode(t.grade,'B',1,0) ) AS Grade_B,
sum(decode(t.grade,'C',1,0) ) AS Grade_C,
sum(decode(t.grade,'F',1,0) ) AS Grade_F from transcript t right outer join COURSE c on t.C_NO = c.C_NO AND t.D_CODE = c.D_CODE
 group by c.D_CODE,c.C_NO having c.d_code='INFS';

--8
select p.D_CODE,p.C_NO, count(DISTINCT p.p_no) from prereq p group by p.D_CODE,p.C_NO having count(DISTINCT p.p_no) = 3;