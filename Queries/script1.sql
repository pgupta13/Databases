 
                                                      /* Homework Assignment 3 for CS 550
                                                    By Prachi Gupta, G01025257, user: pgupta13 */

/* Create table */
CREATE TABLE MUSICIANS (
  SSN NUMBER(9) PRIMARY KEY,
  NAME VARCHAR(500) NOT NULL,
  ANNUALINCOME INTEGER
);

CREATE TABLE INSTRUMENTS (
  INSTRID NUMBER(4) PRIMARY KEY,
  INAME VARCHAR(100) NOT NULL,
  IKEY VARCHAR(20)
  );
  
  CREATE TABLE PLAYS (
  SSN NUMBER(9) NOT NULL,
  INSTRID NUMBER(4) NOT NULL,
  PRIMARY KEY (SSN, INSTRID),
  FOREIGN KEY(SSN) REFERENCES MUSICIANS(SSN) ON DELETE CASCADE,
  FOREIGN KEY(INSTRID) REFERENCES INSTRUMENTS(INSTRID) ON DELETE CASCADE
);

CREATE TABLE PLACE (
  ADDRESS VARCHAR(500) PRIMARY KEY,
  OTHERINFO VARCHAR(1000)
);

CREATE TABLE LIVES (
  SSN NUMBER(9) NOT NULL,
  ADDRESS VARCHAR(500) NOT NULL,
  PHONE NUMBER(10),
  PRIMARY KEY (SSN, ADDRESS),
  FOREIGN KEY(SSN) REFERENCES MUSICIANS(SSN) ON DELETE CASCADE, 
  FOREIGN KEY(ADDRESS) REFERENCES PLACE(ADDRESS) ON DELETE CASCADE
);

CREATE TABLE ALBUMPRODUCER (
  SSN NUMBER(9) NOT NULL,
  ALBUMIDENTIFIER NUMBER(3) PRIMARY KEY,
  COPYRIGHTDATE DATE NOT NULL,
  SPEED INTEGER,
  TITLE VARCHAR(100),
  FOREIGN KEY(SSN) REFERENCES MUSICIANS(SSN),
  UNIQUE (ALBUMIDENTIFIER,SSN)
);

CREATE TABLE SONGSAPPEARS(
  SONGID VARCHAR(20) PRIMARY KEY,
  AUTHORSSN NUMBER(9),
  TITLE VARCHAR(100) NOT NULL,
  ALBUMIDENTIFIER NUMBER(3),
  FOREIGN KEY(AUTHORSSN,ALBUMIDENTIFIER) REFERENCES ALBUMPRODUCER(SSN,ALBUMIDENTIFIER)
);

CREATE TABLE PERFORM(
  SONGID VARCHAR(20) NOT NULL,
  SSN NUMBER(9) NOT NULL,
  PRIMARY KEY (SONGID,SSN),
  FOREIGN KEY(SSN) REFERENCES MUSICIANS(SSN) ON DELETE CASCADE,
  FOREIGN KEY(SONGID) REFERENCES SONGSAPPEARS(SONGID) ON DELETE CASCADE
);


/*Insert data into tables*/

insert into musicians values('123456789','john','100000');
insert into musicians values('634343873','watson','100000');
insert into musicians values('652338435', 'sherlock','200000');
insert into musicians values('876453283', 'john','10000');
insert into musicians values('675646638', 'john','700000');
insert into musicians values('653436653', 'john','700000');
insert into musicians values('782355495', 'Mark','2000000');

insert into instruments values('1001', 'guitar','played by musician');
insert into instruments values('1002', 'piano','played by musician');


insert into PLAYS values('876453283',	'1002');
insert into PLAYS values('675646638',	'1001');
insert into PLAYS values('876453283',	'1001');
insert into PLAYS values('653436653',	'1002');




insert into albumproducer (SSN,ALBUMIDENTIFIER,COPYRIGHTDATE,SPEED,TITLE) values ('675646638', '110', '10-march-2005', '40', 'happy times');
insert into albumproducer (SSN,ALBUMIDENTIFIER,COPYRIGHTDATE,SPEED,TITLE) values ('782355495',	'999',	'19-MARCH-17',	'70',	'testalbum');
insert into albumproducer (SSN,ALBUMIDENTIFIER,COPYRIGHTDATE,SPEED,TITLE) values ('876453283',	'123',	'14-MARCH-17',	'40',	'afreen afreen');



insert into songsappears(SONGID,AUTHORSSN,TITLE,ALBUMIDENTIFIER) values('song1','876453283','afreen afreen','123');
insert into songsappears(SONGID,AUTHORSSN,TITLE,ALBUMIDENTIFIER) values('song2','876453283','afreen afreen','123');
insert into songsappears(SONGID,AUTHORSSN,TITLE,ALBUMIDENTIFIER) values('song3','675646638','happy times','110');


insert into perform (SONGID,
SSN) values ('song1','675646638');
insert into perform (SONGID,
SSN) values ('song2','675646638');
insert into perform (SONGID,
SSN) values ('song3','652338435');


/*Query for Assignment 3 questions */

/*Query for question 1*/
 select distinct instrID from plays natural join musicians where name = 'john';

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
 select m.name,m.ssn from musicians m where not exists (select p.songid,p.ssn from perform p where m.ssn = p.SSN minus
(select s.songid,s.authorssn from songsappears s where m.ssn = s.AUTHORSSN ));
 
/*Query for question 14*/
select m.name,m.ssn from musicians m where not exists (select p.songid,p.ssn from perform p where m.ssn = p.SSN minus
(select s.songid,s.authorssn from songsappears s where m.ssn = s.AUTHORSSN ));
