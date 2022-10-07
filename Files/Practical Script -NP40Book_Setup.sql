/* DB Book						*/
/* DatabaseSetup.sql					*/
/* Creation Date: 12/6/2003	 			*/
/* Last Updated Date: 7 Sep 2015            */

/*** Delete database if it exists ***/
USE master
IF EXISTS(select * from sys.databases where name='NP40Book')
DROP DATABASE NP40Book
GO

Create Database NP40Book
GO

use NP40Book
GO

/*** Delete tables (if they exist) before creating ***/

/* Table: dbo.Loan */
if exists (select * from sysobjects 
  where id = object_id('dbo.Loan') and sysstat & 0xf = 3)
  drop table dbo.Loan
GO

/* Table: dbo.BookCopy */
if exists (select * from sysobjects 
  where id = object_id('dbo.BookCopy') and sysstat & 0xf = 3)
  drop table dbo.BookCopy
GO

/* Table: dbo.Student */
if exists (select * from sysobjects 
  where id = object_id('dbo.Student') and sysstat & 0xf = 3)
  drop table dbo.Student
GO

/* Table: dbo.Member */
if exists (select * from sysobjects 
  where id = object_id('dbo.Member') and sysstat & 0xf = 3)
  drop table dbo.Member
GO


/* Table: dbo.StaffContact */
if exists (select * from sysobjects 
  where id = object_id('dbo.StaffContact') and sysstat & 0xf = 3)
  drop table dbo.StaffContact
GO

/* Drop foreign key constraint in dbo.Branch to dbo.Staff */
if exists (select * from sysobjects 
  where id = object_id('dbo.Branch') and sysstat & 0xf = 3)
  ALTER TABLE dbo.Branch
  DROP CONSTRAINT FK_Branch_MgrID 
GO

/* Table: dbo.Staff */
if exists (select * from sysobjects 
  where id = object_id('dbo.Staff') and sysstat & 0xf = 3)
  drop table dbo.Staff
GO

/* Table: dbo.Branch */
if exists (select * from sysobjects 
  where id = object_id('dbo.Branch') and sysstat & 0xf = 3)
  drop table dbo.Branch
GO

/* Table: dbo.BookAuthor */
if exists (select * from sysobjects 
  where id = object_id('dbo.BookAuthor') and sysstat & 0xf = 3)
  drop table dbo.BookAuthor
GO

/* Table: dbo.Book */
if exists (select * from sysobjects 
  where id = object_id('dbo.Book') and sysstat & 0xf = 3)
  drop table dbo.Book
GO

/* Table: dbo.Author */
if exists (select * from sysobjects 
  where id = object_id('dbo.Author') and sysstat & 0xf = 3)
  drop table dbo.Author
GO

/* Table: dbo.BookCategory */
if exists (select * from sysobjects 
  where id = object_id('dbo.BookCategory') and sysstat & 0xf = 3)
  drop table dbo.BookCategory
GO

/* Table: dbo.Publisher */
if exists (select * from sysobjects 
  where id = object_id('dbo.Publisher') and sysstat & 0xf = 3)
  drop table dbo.Publisher
GO


/*** Create tables ***/
/* Table: dbo.Branch 	*/
CREATE TABLE dbo.Branch 
(
  BranchNo 		tinyint 	        ,
  Address 		varchar (150) 	NOT NULL,
  TelNo 		char (10) 	NOT NULL,
  DateStart		smalldatetime	NULL,
  MgrID			tinyint		NULL,
  CONSTRAINT PK_Branch PRIMARY KEY NONCLUSTERED (BranchNo)
)
GO

/* Table: dbo.Staff 	*/
CREATE TABLE dbo.Staff 
(
  StaffID 		tinyint 		,
  Name 			varchar (50) 	NOT NULL,
  Gender 		char (1) 	NOT NULL CHECK (Gender IN ('M', 'F')),
  DOB			smalldatetime 	NOT NULL CHECK (datediff(yy, DOB, GETDATE()) >= 16),
  DateJoin		smalldatetime 	NOT NULL DEFAULT (GETDATE()) 
						CHECK (DateJoin <= GETDATE()),
  Salary		smallmoney	NOT NULL,
  BranchNo		tinyint		NULL,
  SupervisorID          tinyint         NULL,
  CONSTRAINT PK_Staff PRIMARY KEY NONCLUSTERED (StaffID),
  CONSTRAINT FK_Staff_BranchNo FOREIGN KEY (BranchNo) REFERENCES
  dbo.Branch(BranchNo),
  CONSTRAINT FK_Staff_SupervisorID FOREIGN KEY (SupervisorId) REFERENCES
  dbo.Staff(StaffID),
  CONSTRAINT CHK_Staff_Gender CHECK (Gender IN ('M', 'F'))
)
GO

/* Add foreign key constraint to dbo.Branch */
ALTER TABLE dbo.Branch
  ADD CONSTRAINT FK_Branch_MgrID FOREIGN KEY (MgrID) REFERENCES      
  dbo.Staff(StaffID)
GO

/* Table: dbo.StaffContact 	*/
CREATE TABLE dbo.StaffContact 
(
  StaffID 		tinyint  ,
  ContactNo 		char (10),
  CONSTRAINT PK_StaffContact PRIMARY KEY NONCLUSTERED (StaffID,ContactNo),
  CONSTRAINT FK_StaffContact_StaffID FOREIGN KEY (StaffID) REFERENCES
  dbo.Staff(StaffID)
)
GO


/* Table: dbo.Member 	*/
CREATE TABLE dbo.Member 
(
  MemberID 		smallint 		,
  Name 			varchar (50) 	NOT NULL,
  Address 		varchar (150) 	NULL,
  ContactNo 		char (10) 	NULL,
  EmailAddr 		varchar (50) 	NULL,
  Gender 		char (1) 	NULL CHECK (Gender IN ('M', 'F')),
  DateJoin		smalldatetime 	NOT NULL DEFAULT (GETDATE()) 
						CHECK (DateJoin <= GETDATE()),
  BranchNo		tinyint		NOT NULL,
  CONSTRAINT PK_Member PRIMARY KEY NONCLUSTERED (MemberID),
  CONSTRAINT FK_Member_BranchNo FOREIGN KEY (BranchNo) REFERENCES
  dbo.Branch(BranchNo)
)
GO

/* Table: dbo.Student 	*/
CREATE TABLE dbo.Student 
(
  MemberID 		smallint 		,
  School 		varchar (50) 	NOT NULL,
  CONSTRAINT PK_Student PRIMARY KEY NONCLUSTERED (MemberID),
  CONSTRAINT FK_Student_MemberID FOREIGN KEY (MemberID) REFERENCES
  dbo.Member(MemberID)
)
GO

/* Table: dbo.BookCategory 	*/
CREATE TABLE dbo.BookCategory 
(
  BookCat 		char (2) 	,
  Description		varchar (100)	NOT NULL,
  CONSTRAINT PK_BookCategory PRIMARY KEY NONCLUSTERED (BookCat)
)
GO

/* Table: dbo.Author 	*/
CREATE TABLE dbo.Author
(
  AuthorID	 	smallint 		,
  Name			varchar (50)	NOT NULL,
  CONSTRAINT PK_Author PRIMARY KEY NONCLUSTERED (AuthorID)
)
GO

/* Table: dbo.Publisher 	*/
CREATE TABLE dbo.Publisher 
(
  PublisherID 		smallint 		,
  Name			varchar (50)	NOT NULL,
  CONSTRAINT PK_Publisher PRIMARY KEY NONCLUSTERED (PublisherID)
)
GO

/* Table: dbo.Book 	*/
CREATE TABLE dbo.Book 
(
  ISBN	 		char (10)	,
  Title			varchar (200)	NOT NULL,
  YearPublish		char(4) 	NOT NULL,
  PublisherID		smallint		NULL,
  BookCat		char (2)	NULL,
  CONSTRAINT PK_Book PRIMARY KEY NONCLUSTERED (ISBN),
  CONSTRAINT FK_Book_PublisherID FOREIGN KEY (PublisherID) REFERENCES
  dbo.Publisher(PublisherID),
  CONSTRAINT FK_Book_BookCat FOREIGN KEY (BookCat) REFERENCES
  dbo.BookCategory(BookCat)
)
GO

/* Table: dbo.BookCopy 	*/
CREATE TABLE dbo.BookCopy 
(
  ISBN	 		char (10)	,
  CopyNo		tinyint		,
  DateIn		smalldatetime 	NOT NULL DEFAULT GETDATE() 
						CHECK (DateIn <= GETDATE()),
  RentalRate		smallmoney	NOT NULL check (RentalRate >= 2.50),
  Status		char (1)	NULL check (Status in ('M', 'D')),
  CONSTRAINT PK_BookCopy PRIMARY KEY NONCLUSTERED (ISBN, CopyNo),
  CONSTRAINT FK_BookCopy_ISBN FOREIGN KEY (ISBN) REFERENCES dbo.Book(ISBN)
)
GO

/* Table: dbo.BookAuthor 	*/
CREATE TABLE dbo.BookAuthor 
(
  ISBN 			char (10) 	,
  AuthorID		smallint		,
  CONSTRAINT PK_BookAuthor PRIMARY KEY NONCLUSTERED (ISBN,AuthorID),
  CONSTRAINT FK_BookAuthor_ISBN FOREIGN KEY (ISBN) REFERENCES
  dbo.Book(ISBN),
  CONSTRAINT FK_BookAuthor_AuthorID FOREIGN KEY (AuthorID) REFERENCES
  dbo.Author(AuthorID)
)
GO

/* Table: dbo.Loan 	*/
CREATE TABLE dbo.Loan 
(
  LoanNo 		int 	IDENTITY(1,1),
  DateOut		smalldatetime 	NOT NULL DEFAULT (GETDATE())
						CHECK (DateOut <= GETDATE()),
  DateDue		smalldatetime	NOT NULL,
  DateReturn		smalldatetime	NULL,
  RentalRate		smallmoney	NOT NULL CHECK (RentalRate >= 2.5),
  ISBN			char (10)	NOT NULL,
  CopyNo		tinyint		NOT NULL,
  MemberID		smallint	NOT NULL,
  CONSTRAINT PK_Loan PRIMARY KEY NONCLUSTERED (LoanNo),
  CONSTRAINT FK_Loan_ISBN_CopyNo FOREIGN KEY (ISBN, CopyNo)   
  REFERENCES    dbo.BookCopy(ISBN, CopyNo),
  CONSTRAINT FK_Loan_MemberID FOREIGN KEY (MemberID) REFERENCES      
  dbo.Member(MemberID),
  CONSTRAINT CHK_Loan_DateDue CHECK (DateDue > DateOut),
  CONSTRAINT CHK_Loan_DateReturn CHECK (DateReturn >= DateOut)
)
GO



/* Insert rows */
insert into BookCategory values ('C','Children')
insert into BookCategory values ('F','Fiction')
insert into BookCategory values ('NF','Non-Fiction')

insert into Publisher values (1,'HarperTrophy')
insert into Publisher values (2,'Puffin')
insert into Publisher values (3,'Arrow Books')
insert into Publisher values (4,'Doubleday')
insert into Publisher values (5,'Heinemann')
insert into Publisher values (6,'Pan Books')
insert into Publisher values (7,'Addison Wesley')
insert into Publisher values (8,'McGraw-Hill')

insert into Author values (1,'E. B. White')
insert into Author values (2,'Kenneth Grahame')
insert into Author values (3,'John Grisham')
insert into Author values (4,'John Crichton')
insert into Author values (5,'Catherine Lim')
insert into Author values (6,'James Herriot')

insert into Book values ('0064410935','Charlotte''s Web','2001',1,'C')
insert into Book values ('0064408671','The Trumpet of the Swan','2000',1,'C')
insert into Book values ('0064410927','Stuart Little','2001',1,'C')
insert into Book values ('0140366857','The Wind in the Willows','1995',2,'C')
insert into Book values ('0099245027','The Testament','1999',3,'F')
insert into Book values ('0099826704','The Firm','1991',3,'F')
insert into Book values ('0385503822','The Summons','2002',4,'F')
insert into Book values ('0099895102','Jurassic Park','1991',3,'F')
insert into Book values ('9971643359','The Best of Catherine Lim','1993',5,'F')
insert into Book values ('0330250493','All Things Great and Small','1976',6,'NF')
insert into Book values ('0330255800','All Things Bright and Beautiful','1978',6,'NF')
insert into Book values ('0201708574','Database Systems','2002',null,null)
insert into Book values ('0072126949','SQL Server 2000 Database Design','2001',null,null)

insert into BookCopy values ('0064410935',1,'01-Jun-2015',9.50,null)
insert into BookCopy values ('0064408671',1,'10-Dec-2014',8.00,null)
insert into BookCopy values ('0064410927',1,'03-Jan-2015',9.00,null)
insert into BookCopy values ('0140366857',1,'15-Mar-2013',6.50,null)
insert into BookCopy values ('0099245027',1,'20-Jul-2013',5.50,null)
insert into BookCopy values ('0099826704',1,'02-Jan-2012',4.50,'D')
insert into BookCopy values ('0385503822',1,'20-Oct-2014',15.50,null)
insert into BookCopy values ('0099895102',1,'01-Dec-2011',5.50,'D')
insert into BookCopy values ('9971643359',1,'01-Jun-2012',10.50,null)
insert into BookCopy values ('0330250493',1,'01-Dec-2011',7.00,null)
insert into BookCopy values ('0330255800',1,'01-Dec-2011',6.00,null)

insert into BookCopy values ('0064410935',2,'01-Jun-2014',8.50,null)
insert into BookCopy values ('0099245027',2,'20-Jul-2012',5.00,null)
insert into BookCopy values ('0099826704',2,'02-Jan-2011',4.00,null)
insert into BookCopy values ('0385503822',2,'20-Oct-2014',17.00,null)
insert into BookCopy values ('0099895102',2,'01-Dec-2010',5.00,null)
insert into BookCopy values ('9971643359',2,'01-Jun-2011',10.00,null)

insert into BookCopy values ('0064410935',3,'01-Jun-2013',8.50,null)
insert into BookCopy values ('0099245027',3,'20-Jul-2012',6.50,null)
insert into BookCopy values ('0099826704',3,'02-Jan-2010',5.50,null)
insert into BookCopy values ('0385503822',3,'20-Oct-2014',14.50,null)

insert into BookAuthor values ('0064410935',1)
insert into BookAuthor values ('0064408671',1)
insert into BookAuthor values ('0064410927',1)
insert into BookAuthor values ('0140366857',2)
insert into BookAuthor values ('0099245027',3)
insert into BookAuthor values ('0099826704',3)
insert into BookAuthor values ('0385503822',3)
insert into BookAuthor values ('0099895102',4)
insert into BookAuthor values ('9971643359',5)
insert into BookAuthor values ('0330250493',6)
insert into BookAuthor values ('0330255800',6)

insert into Staff values (1,'Richard','M','02-Jan-1988','09-Sep-2013',1500,null,null)
insert into Staff values (2,'John','M','02-Feb-1989','19-Sep-2012',1500,null,1)
insert into Staff values (3,'Mary','F','03-Mar-1990','03-Sep-2014',1970,null,null)
insert into Staff values (4,'Sun Sun','F','14-Apr-1984','22-Oct-2011',1300,null,null)
insert into Staff values (5,'Jane','F','15-Feb-1989','22-Oct-2011',1390,null,null)
insert into Staff values (6,'Nana','M','02-Jan-1989','03-Sep-2014',2100,null,null)
insert into Staff values (7,'May May','F','27-Jul-1990','03-Sep-2014',1990,null,null)
insert into Staff values (8,'Sadiah','F','12-May-1987','23-Oct-2014',1450,null,7)
insert into Staff values (9,'Samuel','M','25-Dec-1986','16-Dec-2013',1350,null,7)

update Staff 
   set SupervisorID = 3
   where StaffId = 1

update Staff 
   set SupervisorID = 5
   where StaffId = 4

update Staff 
   set SupervisorID = 6
   where StaffId = 5


insert into StaffContact values (1,'67654321')
insert into StaffContact values (1,'97654322')
insert into StaffContact values (3,'67654323')
insert into StaffContact values (4,'67654324')
insert into StaffContact values (7,'67654327')

insert into Branch values (1,'1,Tulip Plaza','61111111','03-Sep-2013',3)
insert into Branch values (2,'2,Hibiscus Mall','62222222','01-Oct-2013',6)
insert into Branch values (3,'3,Rose Central','63333333','15-Sep-2013',7)

update Staff 
  set BranchNo = 1 
  where StaffID between 1 and 3

update Staff 
  set BranchNo = 2 
  where StaffID between 4 and 6

update Staff 
  set BranchNo = 3 
  where StaffID between 7 and 9

insert into Member values (1,'Chan Kim Kim','1, Gold Street, Singapore 111111','61234561','kimkim@freemail.com.sg','F','31-Dec-2013',1)
insert into Member values (2,'Tan Mei Ling','2, Silver Street, Singapore 222222','61234562',null,'F','11-Nov-2013',1)
insert into Member values (3,'Jeremy Law','3, Bronze Street, Singapore 333333','61234563','JLaw@freemail.com.sg','M','15-Jun-2014',2)
insert into Member values (4,'Lim Ah Gek','4, Apple Lane, Singapore 444444','61234564','AhGek@freemail.com.sg','F','20-Jul-2014',2)
insert into Member values (5,'Siti','5, Durian Lane, Singapore 555555','61234565','Siti@freemail.com.sg','F','30-Sep-2014',3)
insert into Member values (6,'Kumar','6, Mango Lane, Singapore 666666','61234566','Kumar@freemail.com.sg','M','31-Dec-2013',3)
insert into Member values (7,'Steven Fine','7, Papaya Close, Singapore 777777','61234567',null,'M','10-Jan-2014',3)

insert into Student values (2,'Excel Polytechnic')
insert into Student values (6,'Orchid Junior College')

insert into Loan values ('15-Jun-2015','16-Jun-2015','21-Aug-2015',10.00,'0064410935',1,1)
insert into Loan values ('16-Oct-2014','6-Nov-2014','21-Oct-2014',9.00,'0064410935',2,4)
insert into Loan values ('12-Jan-2015','2-Feb-2015','22-Jan-2015',9.00,'0064410935',3,3)
insert into Loan values ('15-Dec-2014','25-Dec-2014','27-Feb-2015',9.00,'0064408671',1,1)
insert into Loan values ('2-Feb-2015','23-Feb-2015','27-Feb-2015',8.50,'0064408671',1,7)
insert into Loan values ('16-Jan-2015','6-Feb-2015','26-Jan-2015',9.50,'0064410927',1,2)
insert into Loan values ('22-Mar-2015','2-Jan-2016','26-Mar-2015',9.00,'0064410927',1,5)
insert into Loan values ('4-Apr-2015','2-Jan-2016','22-Apr-2015',8.50,'0064410927',1,6)
insert into Loan values ('27-Nov-2014','2-Jan-2015','9-Dec-2014',6.50,'0140366857',1,7)
insert into Loan values ('12-Oct-2014','2-Jan-2015','19-Oct-2014',7.00,'0099245027',1,3)
insert into Loan values ('28-Oct-2014','2-Jan-2015','9-Nov-2014',5.50,'0099245027',2,4)
insert into Loan values ('12-Dec-2014','2-Jan-2015','22-Mar-2015',7.00,'0099245027',3,2)
insert into Loan values ('17-Jan-2015','2-Jan-2016','3-Feb-2015',5.50,'0099826704',1,1)
insert into Loan values ('11-Feb-2015','2-Jan-2016','23-Feb-2015',4.50,'0099826704',2,7)
insert into Loan values ('7-Mar-2015','2-Jan-2016','20-Mar-2015',6.00,'0099826704',3,6)
insert into Loan values ('22-Oct-2014','2-Jan-2015','25-Oct-2014',16.00,'0385503822',1,2)
insert into Loan values ('2-Apr-2015','2-Jan-2016',null,15.50,'0385503822',3,5)
insert into Loan values ('22-Jan-2015','2-Jan-2016','30-Jan-2015',6.00,'0099895102',1,5)
insert into Loan values ('20-Apr-2015','2-Jan-2016',null,11.00,'9971643359',1,1)
insert into Loan values ('20-Dec-2014','2-Jan-2015','3-Jan-2015',10.50,'9971643359',2,5)
insert into Loan values ('14-Oct-2014','2-Jan-2015','26-Oct-2014',9.50,'0330250493',1,6)
insert into Loan values ('21-Nov-2014','2-Jan-2015','4-Dec-2014',9.00,'0330250493',1,1)
insert into Loan values ('21-Mar-2015','2-Jan-2016','2-Apr-2015',8.50,'0330250493',1,2)
insert into Loan values ('11-Oct-2014','2-Jan-2015','24-Oct-2014',8.00,'0330255800',1,3)
insert into Loan values ('21-Oct-2014','2-Jan-2015','8-Nov-2014',7.50,'0330255800',1,1)
insert into Loan values ('11-Dec-2014','2-Jan-2015','27-Dec-2014',7.00,'0330255800',1,5)
insert into Loan values ('2-Feb-2015','2-Jan-2016','14-Feb-2015',6.50,'0330255800',1,7)

update Loan
  set DateDue = DateOut + 21

update Loan
   set DateReturn = null
   where LoanNo in (8,27)

SELECT * FROM Branch 
SELECT * FROM Staff 
SELECT * FROM StaffContact 
SELECT * FROM Member 
SELECT * FROM Student 
SELECT * FROM BookCategory 
SELECT * FROM Author 
SELECT * FROM Publisher 
SELECT * FROM Book 
SELECT * FROM BookCopy 
SELECT * FROM BookAuthor 
SELECT * FROM Loan 

/* test consistency of data 

Select loanno, dateIn, DateOut
from loan l inner join bookcopy bc
on l.isbn = bc.isbn and l.copyno = bc.copyno
where dateout <= dateIn

Select loanno, dateReturn, DateOut
from loan l 
where dateout >= dateReturn

*/
