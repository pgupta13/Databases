 
                                                      /* Homework Assignment 3 for CS 550
                                                    By Prachi Gupta, G01025257, user: pgupta13 */
 
 /*Query for question 1*/
 select distinct instrID from plays natural join musicians where name = 'John';

 /*Query for question 2*/
SELECT distinct p.instrID
 FROM plays p where not exists 
 (select m.ssn from musicians m where m.name ='John' minus
 select p1.ssn from plays p1 where  p.instrID = p1.instrID);

 /*Query for question 3*/
select instrID from ((select ssn, instrID from plays  natural join musicians)minus (select ssn, instrID from plays natural join musicians where musicians.name <> 'John' ));

/*Query for question 4*/
select distinct title from albumproducer natural join  (select ssn from plays natural join instruments where iname = 'guitar' or iname ='piano');

/*Query for question 5*/
select M.ssn,M.name  from  musicians M, perform p1, perform p2  where (p1.songid='song1' AND p2.songid='song2' AND p1.SSN= p2.ssn AND M.ssn = p1.ssn);
 
 /*Query for question 6*/
(select name, ssn from musicians) minus ( select m.name,m.ssn from musicians m , musicians m1 where (m1.annualIncome > m.annualIncome) );

/*Query for question 7*/
(select t.name,t.annualIncome from musicians t) minus (select m1.name,m1.annualIncome from musicians m1, musicians m2 where m1.ANNUALINCOME<m2.annualIncome);

/*Query for question 8*/
select distinct m1.name ,m2.name from musicians m1, musicians m2, lives l1, lives l2  where( m1.ssn = l1.ssn and m2.ssn = l2.ssn AND l1.ssn <> l2.ssn AND l1.address = l2.address );

/*Query for question 9*/
select distinct m1.name from musicians m1,  perform p, SONGSAPPEARS S where (p.ssn = s.authorssn AND m1.ssn = p.SSN AND m1.ssn = S.AUTHORSSN);

/*Query for question 10*/
select m1.name  from musicians m1, musicians m2, perform p, SONGSAPPEARS S where (m2.name ='john' AND m2.ssn = S.AUTHORSSN AND S.songID = p.songID AND p.SSN = m1.SSN);

/*Query for question 11*/
select distinct m1.name from musicians m1,  perform p, SONGSAPPEARS S where (p.ssn = s.authorssn AND m1.ssn = p.SSN AND m1.ssn = S.AUTHORSSN);

/*Query for question 12*/
select m.name,m.ssn from musicians m where not exists (select s.songid,s.authorssn from songsappears s where m.ssn = s.AUTHORSSN minus
(select p.songID,p.ssn from perform p where m.ssn = p.ssn ));


/*Query for question 13*/
  (select distinct m. name ,m.ssn from musicians m,  SONGSAPPEARS S natural join perform p  where  (p.ssn = S.AUTHORSSN AND m.ssn= p.ssn AND m.ssn = s.authorssn )) minus 
(select distinct m1.name,p1.ssn from MUSICIANS m1, songsappears S1 natural join perform p1 where (p1.ssn != S1.authorssn AND S1.authorssn = m1.ssn) );

/*Query for question 14*/
(select distinct m. name ,m.ssn from musicians m,  SONGSAPPEARS S natural join perform p  where  (p.ssn = S.AUTHORSSN AND m.ssn= p.ssn AND m.ssn = s.authorssn )) minus 
(select distinct m1.name,p1.ssn from MUSICIANS m1, songsappears S1 natural join perform p1 where (p1.ssn != S1.authorssn AND S1.authorssn = m1.ssn) );
