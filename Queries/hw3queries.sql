 select distinct instrID from plays natural join musicians where name = 'john';

SELECT distinct p.instrID
 FROM plays p where not exists 
 (select m.ssn from musicians m where m.name ='John' minus
 select p1.ssn from plays p1 where  p.instrID = p1.instrID);

select instrID from ((select ssn, instrID from plays  natural join musicians)minus (select ssn, instrID from plays natural join musicians where musicians.name <> 'John' ));


select distinct title from albumproducer natural join  (select ssn from plays natural join instruments where iname = 'guitar' or iname ='piano');

select M.ssn,M.name  from  musicians M, perform p1, perform p2  where (p1.songid='song1' AND p2.songid='song2' AND p1.SSN= p2.ssn AND M.ssn = p1.ssn);
 
(select name, ssn from musicians) minus ( select m.name,m.ssn from musicians m , musicians m1 where (m1.annualIncome > m.annualIncome) );

(select t.name,t.annualIncome from musicians t) minus (select m1.name,m1.annualIncome from musicians m1, musicians m2 where m1.ANNUALINCOME<m2.annualIncome);

select distinct m1.name ,m2.name from musicians m1, musicians m2, lives l1, lives l2  where( m1.ssn = l1.ssn and m2.ssn = l2.ssn AND l1.ssn <> l2.ssn AND l1.address = l2.address );

select distinct m1.name from musicians m1,  perform p, SONGSAPPEARS S where (p.ssn = s.authorssn AND m1.ssn = p.SSN AND m1.ssn = S.AUTHORSSN);

select m1.name  from musicians m1, musicians m2, perform p, SONGSAPPEARS S where (m2.name ='john' AND m2.ssn = S.AUTHORSSN AND S.songID = p.songID AND p.SSN = m1.SSN);
select distinct m1.name from musicians m1,  perform p, SONGSAPPEARS S where (p.ssn = s.authorssn AND m1.ssn = p.SSN AND m1.ssn = S.AUTHORSSN);

(select distinct m. name ,m.ssn from perform p, SONGSAPPEARS S,musicians m where (p.ssn = S.AUTHORSSN AND m.ssn= p.ssn AND m.ssn = s.authorssn )) minus 
(select distinct m1.name,m1.ssn from MUSICIANS m1, songsappears S1, perform p1 where (p1.ssn != S1.authorssn AND m1.ssn = p1.ssn) );



  (select distinct m. name ,m.ssn from musicians m,  SONGSAPPEARS S natural join perform p  where  (p.ssn = S.AUTHORSSN AND m.ssn= p.ssn AND m.ssn = s.authorssn )) minus 
(select distinct m1.name,p1.ssn from MUSICIANS m1, songsappears S1 natural join perform p1 where (p1.ssn != S1.authorssn AND S1.authorssn = m1.ssn) );

(select distinct m. name ,m.ssn from musicians m,  SONGSAPPEARS S natural join perform p  where  (p.ssn = S.AUTHORSSN AND m.ssn= p.ssn AND m.ssn = s.authorssn )) minus 
(select distinct m1.name,p1.ssn from MUSICIANS m1, songsappears S1 natural join perform p1 where (p1.ssn != S1.authorssn AND S1.authorssn = m1.ssn) );
