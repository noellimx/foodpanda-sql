SELECT GETDATE () AS Today

select DATEPART(day, GETDATE()   )  as day    

select DATEPART(month, GETDATE()   )  as month      

select DATENAME(month, GETDATE()   )  as month      

SELECT GETDATE () AS Today,
DATEPART (day,GETDATE()) AS Day,
DATENAME (month,GETDATE()) AS Month

select * from staff

SELECT StaffID, Name, DateJoin,
DATEADD (month, 6, DateJoin)
As 'Confirmation Date'
FROM Staff

SELECT StaffID, Name,DOB,
DATEDIFF (Year, DOB, GETDATE()) As Age
FROM Staff

SELECT CONVERT (VARCHAR(12), 
GETDATE(), 103) 

SELECT CONVERT (VARCHAR(12), 
GETDATE()) 

SELECT CAST (CopyNo AS CHAR(2)) CopyNo
FROM BookCopy
WHERE Status IS NOT NULL

SELECT CopyNo 
FROM BookCopy
WHERE Status IS NOT NULL

SELECT Name, Address, EmailAddr FROM Member

SELECT Name, Address, ISNULL (EmailAddr, 
'Email not available ') FROM Member

select * from Branch

SELECT COUNT(*) AS 'No. of Branches' FROM Branch

SELECT COUNT(EmailAddr) AS 'EmailAddr' FROM Member
SELECT COUNT(*) FROM Member

SELECT EmailAddr FROM Member

select min(salary) MinSalary from Staff

select max(salary) MAxSalary from staff

select avg(salary) AvgSalary from staff

select sum(salary) SumSalary from staff

--practical 3 
--1
--d e
SELECT YEAR(GETDATE())
SELECT DAY(GETDATE() )

--2
SELECT MemberID,Name,DateJoin,DATEDIFF (Year, DateJoin, GETDATE()) AS 'Years of Membership' 
FROM Member
ORDER BY [Years of Membership]ASC

SELECT MemberId, Name, DateJoin, DATEDIFF(year, DateJoin, GetDate()) AS 'Years of Membership' FROM Member;

--3
select * from loan

SELECT LoanNo, ISBN, CopyNo, MemberID, -- No. Days Overdue
DATEDIFF(Day, DateDue, DateReturn)AS 'Number of Days Overdue'
FROM Loan
WHERE DateDue < DateReturn
ORDER BY 'Number of Days Overdue' DESC

SELECT LoanNo, ISBN, CopyNo, MemberID, DATEDIFF(Day, DateDue, DateReturn) As "Number of Days Overdue" FROM Loan
WHERE DateDue < DateReturn
ORDER BY "Number of Days Overdue" DESC

--4
SELECT StaffID, Name, Gender, DOB from Staff Where datepart(month,DOB) = 2 ORDER BY Name ASC

--Aggregate 
--5
SELECT COUNT(*) AS "Number of Staff" FROM Staff

--6
select * from staff

SELECT COUNT(*) AS 'No of Staff with Supervisor' FROM Staff WHERE SupervisorID IS NOT NULL

SELECT COUNT(SupervisorID) AS 'No of Staff with Supervisor' FROM Staff 

--7
SELECT * from staff
SELECT  COUNT(DISTINCT(SupervisorID)) AS 'Number of staff who are supervisors' from Staff

select count(distinct SupervisorID) from Staff

--8
SELECT * from member
SELECT count(EmailAddr) from member

--9
select count(*) from Member where EmailAddr is NULL


--10
select * from bookcopy
select * from loan

select min(RentalRate) from Loan
select min(RentalRate) from bookcopy

--11
select Count(LoanNo) AS "Number of Loan", SUM(RentalRate) AS "Total Rental Income" 
 from loan where datepart(year, DateOut) = 2014

--12
select * from Staff
SELECT COUNT(StaffID) AS 'Number of Staff', SUM(Salary*12) AS 'Total Annual Salary Payout' FROM Staff

--13
select * from loan

SELECT LoanNo, DateDue AS 'OldDateDue', DateDue + 10 AS 'NewDateDue' from Loan
ORDER BY 'NewDateDue'

SELECT LoanNo, DateDue AS "Old DateDue", DATEADD(day, 10, DateDue) AS "New DateDue" FROM Loan
ORDER BY "New DateDue" ASC

--14
select *from Member
SELECT Name, Address, ISNULL (EmailAddr, 'Email not available ') 'email address' FROM Member

--15
SELECT Name, Address, ContactNo ,EmailAddr FROM Member where  datepart(year, DateJoin) = 2014 and  (EmailAddr is NULL)

--16.	
SELECT MemberID, Name, DateJoin
FROM Member
WHERE DATEDIFF(year, DateJoin, GETDATE()) > 1
ORDER BY DateJoin ASC

--17.	
SELECT ISBN, CopyNo, Status,DateIn, DATEDIFF(year, DateIn, GETDATE()) AS "Number of Years"
FROM BookCopy
WHERE DATEDIFF(year, DateIn, GETDATE()) > 3
ORDER BY DateIn ASC

--18.	
SELECT MemberID, Name, DateJoin
FROM Member
WHERE DATEPART(year, DateJoin) = 2014
ORDER BY DateJoin ASC

--Alternative solution:
SELECT MemberID, Name, DateJoin
FROM Member
WHERE DATENAME(year, DateJoin) = 2014
ORDER BY DateJoin ASC

--19.	
SELECT MAX (RentalRate) FROM BookCopy

--20.	
SELECT AVG(RentalRate) FROM BookCopy

--21.	
SELECT COUNT(LoanNo) AS "Number of Loan",
SUM(RentalRate) AS "Total Rental Income"
FROM Loan

--22.	
SELECT COUNT(StaffID) AS "Number of Staff",
SUM(Salary) AS "Total Salary Payout"
FROM Staff

--23.	
SELECT UPPER(Name) FROM Member
ORDER BY Name ASC

--24
SELECT SUBSTRING(ISBN, 1, 5), Title FROM Book
ORDER BY SUBSTRING(ISBN, 1, 5) ASC, Title ASC

--25
SELECT ISBN, REPLACE(Title, 'database', 'DB') AS "Title" FROM Book
ORDER BY Title ASC

--26.	
SELECT ISBN, CopyNo, ROUND(RentalRate,0) AS "RentalRate" FROM BookCopy
ORDER BY "RentalRate" DESC

--Alternative solution:
SELECT ISBN, CopyNo, CEILING(RentalRate) AS "RentalRate" FROM BookCopy
ORDER BY "RentalRate" DESC

--27.	
SELECT StaffID, Name, ROUND(Salary, -2) AS "Salary" FROM Staff
ORDER BY "Salary" DESC

--28.	
SELECT COUNT(StaffID) AS "Number of Staff",
AVG(Salary)*12 AS "Average Annual Salary Payout"
FROM Staff

--Alternative solution:
SELECT COUNT(StaffID) AS "Number of Staff",
ROUND(AVG(Salary)*12,0) AS "Average Annual Salary Payout"
FROM Staff



select Name, Address, ContactNo from Member where (EmailAddr is NULL) and datepart(year, DateJoin) < 2014


select * from book
select * from Publisher


SELECT ISBN, Title, Name 
FROM Book, Publisher

SELECT *  
FROM Book, Publisher


SELECT Book.*, Publisher.*
FROM Book INNER JOIN Publisher
ON Book.PublisherID = Publisher.PublisherID


SELECT b.*, p.*
FROM Book b INNER JOIN Publisher p
ON b.PublisherID = p.PublisherID



SELECT ISBN, Title, Name,BookCat
FROM Book b 
INNER JOIN Publisher p
ON b.PublisherID = p.PublisherID 


SELECT ISBN, Title, Name, Description
FROM Book b 
INNER JOIN Publisher p
ON b.PublisherID = p.PublisherID 
INNER JOIN BookCategory bc
ON b.BookCat = bc.BookCat


SELECT s.Name, sup.Name
FROM Staff s INNER JOIN Staff sup
ON s.SupervisorID = sup.StaffID


SELECT Staff.Name  , sup.Name 
FROM Staff INNER JOIN Staff  sup
ON Staff.SupervisorID = sup.StaffID

--practical 4
--1
select  * from book
SELECT BookCopy.ISBN, CopyNo, Book.Title, RentalRate FROM BookCopy INNER JOIN Book On BookCopy.ISBN = Book.ISBN

--2
SELECT b.ISBN, b.Title, bc.Description as "Category" FROM Book b 
INNER JOIN BookCategory bc ON b.BookCat = bc.BookCat

select b.ISBN, b.Title, c.Description as 'Category' from Book b inner join BookCategory c
on b.BookCat = c.BookCat order by b.Title

select b.ISBN, b.Title, c.Description as 'Category' from BookCategory c  inner join  Book b
on b.BookCat = c.BookCat

--3
select * from Branch

SELECT b.BranchNo, b.Address, s.Name FROM Branch b 
INNER JOIN Staff s ON s.StaffID = b.MgrID

select b.BranchNo, b.Address, s.Name from Branch b inner JOIN
Staff s on b.MgrID = s.StaffID

--4
SELECT s.StaffID, s.Name, s.DateJoin FROM Staff s 
INNER JOIN Staff sup ON s.SupervisorID = sup.StaffID 
WHERE sup.Name = 'May May'

--5
SELECT Loan.ISBN, Book.Title, Loan.DateOut FROM Loan
INNER JOIN Member
ON Loan.MemberID = Member.MemberID

INNER JOIN Book
ON Loan.ISBN = Book.ISBN

WHERE Member.Name = 'Kumar'
ORDER BY Loan.DateOut ASC


SELECT b.ISBN, b.Title, l.DateOut FROM Loan l
INNER JOIN Book b ON l.ISBN = b.ISBN
INNER JOIN Member m ON l.MemberID = m.MemberID
WHERE m.Name = 'Kumar'
ORDER BY l.DateOut

--6
select * from book
select * from Author
select * from BookAuthor

SELECT Book.ISBN, Book.Title, Publisher.Name AS "Author" FROM Book
INNER JOIN Publisher ON Book.PublisherID = Publisher.PublisherID
ORDER BY Book.Title ASC

SELECT b.ISBN, b.Title, a.Name
FROM Book b INNER JOIN BookAuthor ba
ON b.ISBN = ba.ISBN
INNER JOIN Author a
ON ba.AuthorID = a.AuthorID
ORDER BY b.Title ASC

SELECT Book.ISBN, Book.Title, Author.Name AS 'Author' FROM Book
INNER JOIN BookAuthor
ON Book.ISBN = BookAuthor.ISBN
INNER JOIN Author
ON BookAuthor.AuthorID = Author.AuthorID
ORDER BY Book.Title ASC

--7
select * from Loan

SELECT COUNT(*) AS 'Number of Loans', SUM(l.RentalRate) AS 'Total Rental Rate'
FROM Loan l INNER JOIN Member m ON l.MemberID = m.MemberID
WHERE m.Name = 'Jeremy Law'

--8
SELECT DISTINCT sup.Name
FROM Staff s INNER JOIN Staff sup ON s.SupervisorID = sup.StaffID
ORDER BY sup.Name

--9
SELECT b.ISBN, b.Title, b.YearPublish
FROM Book b
INNER JOIN BookCategory bc ON bc.BookCat = b.BookCat
INNER JOIN Publisher p ON p.PublisherID = b.PublisherID
WHERE bc.Description = 'Fiction' AND p.Name = 'Arrow Books'
order by b.YearPublish

--10
SELECT s.StaffID, s.Name, s.DateJoin, DATEDIFF(year, s.DateJoin, GETDATE()) AS "Years of Service"
FROM Staff s
INNER JOIN Staff sup ON s.SupervisorID = sup.StaffID
WHERE DATEDIFF(year, s.DateJoin, GETDATE()) < 10 AND sup.Name = 'May May';

--11.	
SELECT l.LoanNo, l.ISBN, m.Name, l.DateOut, l.RentalRate
FROM Loan l
INNER JOIN Member m ON l.MemberID = m.MemberID

--12.	
SELECT b.ISBN, l.CopyNo, l.DateOut 
FROM Loan l
INNER JOIN Book b ON l.ISBN = b.ISBN
WHERE b.Title = 'Stuart Little'

--13.	
SELECT b.ISBN, b.Title, b.YearPublish 
FROM Book b
INNER JOIN Publisher p ON b.PublisherID = p.PublisherID
WHERE p.Name = 'Pan Books'

--14.	
SELECT m.MemberID, m.Name, l.DateDue, l.DateReturn FROM Member m
INNER JOIN loan l ON m.MemberID = l.MemberID
WHERE l.DateReturn > l.DateDue
ORDER BY DateReturn DESC

