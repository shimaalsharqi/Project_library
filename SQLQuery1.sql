CREATE DATABASE librarydb
USE librarydb
create table librarys
(
L_ID int primary key identity(1,1),
L_name varchar(20) NOT NULL UNIQUE,
L_location varchar(20) NOT NULL,
L_contactNumber varchar(20) NOT NULL,
established_year int
)
 
 create table books
 (
 B_ID int primary key identity(1,1),
 Book_ISBN varchar(20) not null UNIQUE,
 title varchar(20) not null,
 shelf_location varchar(20)NOT NULL,
 availability_status BIT DEFAULT 1,
 price decimal(8,2) CHECK (price > 0),
 genre varchar(20) NOT NULL,
 CHECK (genre IN ('Fiction','Non-fiction','Reference','Children')),
  L_ID int,
  CONSTRAINT FK_Books_Library
  foreign key(L_ID) references librarys(L_ID)
  ON DELETE CASCADE
        ON UPDATE CASCADE
  )
  create table Staff
  (
  S_ID int primary key identity(1,1),
  full_name varchar(20) not null,
  position varchar(20) not null,
  s_contact_number varchar(20) NOT NULL,
   L_ID int,
  CONSTRAINT FK_Staff_Library
  foreign key(L_ID) references librarys(L_ID)
  ON DELETE CASCADE
        ON UPDATE CASCADE
  )
  create table members
  (
  M_ID int primary key identity(1,1),
  full_name varchar(20),
  email varchar(20) not null UNIQUE,
  phone_number varchar(20),
  MembershipStartDate date not null
  )

 create table review 
 (
 R_ID int primary key identity(1,1),
 Review_Date date not null,
 comments NVARCHAR(255) DEFAULT 'No comments',
 rating int not null CHECK(rating BETWEEN 1 AND 5),
 B_ID int,
 CONSTRAINT FK_review_Books
 foreign key(B_ID) references books(B_ID)
 ON DELETE CASCADE
        ON UPDATE CASCADE,
 M_ID int,
CONSTRAINT FK_review_members
foreign key(M_ID) references members(M_ID)
ON DELETE CASCADE
        ON UPDATE CASCADE
)
create table loan
(
loan_ID int primary key identity(1,1),
loan_date date not null,
Due_Date date not null,
return_date DATE,
status varchar(20) NOT NULL DEFAULT 'Issued'
        CHECK (status IN ('Issued','Returned','Overdue')),
M_ID int,
CONSTRAINT FK_loan_members
foreign key(M_ID) references members(M_ID)
ON DELETE CASCADE
        ON UPDATE CASCADE,
B_ID int,
 CONSTRAINT FK_loan_Books
 foreign key(B_ID) references books(B_ID)
 ON DELETE CASCADE
        ON UPDATE CASCADE
		)

ALTER TABLE Loan
ADD CONSTRAINT CHK_ReturnDate
CHECK (return_date IS NULL OR return_date >= loan_date);

CREATE TABLE Payments (
    P_ID INT IDENTITY(1,1) PRIMARY KEY,
    payment_date DATE NOT NULL,
    amount DECIMAL(8,2) NOT NULL CHECK (amount > 0),
    method varchar(50),
    loan_ID INT NOT NULL,
    CONSTRAINT FK_Payment_Loan
        FOREIGN KEY (loan_ID)
        REFERENCES Loan(loan_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
INSERT INTO librarys (L_name, L_location, L_contactNumber, established_year)
VALUES
('Central Library', 'Muscat', '24567890', 2005),
('Science Library', 'Salalah', '23456789', 2010),
('Kids Library', 'Nizwa', '22334455', 2015),
('Digital Library', 'Sohar', '21223344', 2018),
('Reference Library', 'Sur', '29887766', 2000)
select * from librarys

INSERT INTO books
(Book_ISBN, title, shelf_location, availability_status, price, genre, L_ID)
VALUES
('978-0001', 'Database Basics', 'A1', 1, 25.50, 'Reference', 1),
('978-0002', 'SQL Guide', 'A2', 1, 30.00, 'Reference', 1),
('978-0003', 'Story Book', 'B1', 1, 15.75, 'Children', 2),
('978-0004', 'Modern Fiction', 'C3', 1, 22.00, 'Fiction', 3),
('978-0005', 'Science Facts', 'D4', 1, 40.00, 'Non-fiction', 4)
select * from books
INSERT INTO Staff
(full_name, position, s_contact_number, L_ID)
VALUES
('Ahmed Ali', 'Manager', '91234567', 1),
('Fatma Said', 'Librarian', '92345678', 1),
('Salim Omar', 'Assistant', '93456789', 2),
('Aisha Khan', 'Librarian', '94567890', 3),
('Hamed Noor', 'Clerk', '95678901', 4);
select * from Staff

INSERT INTO members (full_name, email, phone_number, MembershipStartDate)
VALUES
('Ahmed Ali', 'ahmedl@example.com', '96891234567', '2025-01-01'),
('Fatima Hassan', 'fatim@example.com', '92345678', '2025-02-15'),
('Mohammed Saleh', 'mohammed@example.com', '93456789', '2025-03-10'),
('Layla Karim', 'layla@example.com', '94567890', '2025-04-05'),
('Omar Youssef', 'omar@example.com', '95678901', '2025-05-20')

select * from members

INSERT INTO review (Review_Date, comments, rating, B_ID, M_ID)
VALUES
('2025-06-01', 'Great book, very informative.', 5, 1, 8),
('2025-06-03', 'Good read but a bit long.', 4, 2, 9),
('2025-06-05', 'Not very clear in some chapters.', 3, 1, 12),
('2025-06-07', 'Excellent writing style!', 5, 3, 11),
('2025-06-09', DEFAULT, 4, 2, 10)
select * from  review

INSERT INTO loan (loan_date, Due_Date, return_date, status, M_ID, B_ID)
VALUES
('2025-12-01', '2025-12-15', NULL, DEFAULT, 8, 1),  
('2025-11-20', '2025-12-04', '2025-12-03', 'Returned', 9, 2),
('2025-12-05', '2025-12-19', NULL, DEFAULT, 12, 3),
('2025-11-25', '2025-12-09', '2025-12-10', 'Returned', 11, 4),
('2025-12-07', '2025-12-21', NULL, DEFAULT, 10, 5)
select * from  loan

INSERT INTO Payments (payment_date, amount, method, loan_ID)
VALUES
('2025-12-05', 20.00, 'Cash', 1),
('2025-12-06', 15.50, 'Card', 2),
('2025-12-08', 25.00, 'Online', 3),
('2025-12-10', 18.75, 'Cash', 4),
('2025-12-12', 30.00, 'Card', 8);

select * from Payments


--1)Display all book records.
select * from books
--2)Display each book’s title, genre, and availability
SELECT 
    title,
    genre,
    availability_status
FROM books;
--3)Display all member names, email, and membership start date
SELECT full_name,email, MembershipStartDate
FROM members

--4)Display each book’s title and price as BookPrice.
select title, price as BookPrice
from books

--5)List books priced above 250 LE.(MY DATA IN OMR)
SELECT * from books
where price>25

--6)List members who joined before 2023. 
SELECT * FROM members
WHERE MembershipStartDate < '2023'

--7) Display books published after 2018. 
ALTER TABLE books
ADD published_year INT;

UPDATE books
SET published_year = 2019
WHERE B_ID = 1;

UPDATE books
SET published_year = 2020
WHERE B_ID = 2;

UPDATE books
SET published_year = 2017
WHERE B_ID = 3;

UPDATE books
SET published_year = 2021
WHERE B_ID = 4;

UPDATE books
SET published_year = 2016
WHERE B_ID = 5;

SELECT * FROM books -- to check

SELECT published_year
FROM books
WHERE published_year > 2018

--8)Display books ordered by price descending. 
select * from books
order by price desc

--9)Display the maximum, minimum, and average book price. 
SELECT 
    MAX(price) AS Max_Price,
    MIN(price) AS Min_Price,
    AVG(price) AS Avg_Price
FROM books

--10) Display total number of books. 
SELECT COUNT(*) AS Total_Books
FROM books
--11) Display members with NULL email. 
SELECT * FROM members
WHERE email IS NULL
--12) Display books whose title contains 'Data'
SELECT * FROM books
WHERE title LIKE '%Data%'

--13) Insert yourself as a member (Member ID = 405
SET IDENTITY_INSERT members ON
INSERT INTO members (M_ID, full_name, email, phone_number, MembershipStartDate)
VALUES (405, 'Shima AlSharqi', 'sh@example.com', '90011223', '2025-12-17')

SET IDENTITY_INSERT members OFF
--14)Register yourself to borrow book ID 1011. 
set identity_insert books on
INSERT INTO books (B_ID, Book_ISBN, title, shelf_location, availability_status, price, genre, L_ID)
VALUES (1011, '978-01011', 'Advanced Databases', 'E5', 1, 45.00, 'Reference', 1)

SET IDENTITY_INSERT books OFF

--15)Insert another member with NULL email and phone. 
ALTER TABLE members
ALTER COLUMN  email varchar(50) NULL

ALTER TABLE members
ALTER COLUMN phone_number VARCHAR(20) NULL

INSERT INTO members (full_name, email, phone_number, MembershipStartDate)
VALUES ('New Member', NULL, NULL, GETDATE())

--16) Update the return date of your loan to today.
UPDATE loan
SET return_date = GETDATE(),
    status = 'Returned' 
WHERE M_ID = 405 AND B_ID = 1011

SELECT * FROM loan
WHERE M_ID = 405 AND B_ID = 1011
--17)Increase book prices by 5% for books priced under 200
UPDATE books
SET price = price * 1.05
WHERE price < 200

SELECT title, price
FROM books
WHERE price < 200
--18) Update member status to 'Active' for recently joined members
ALTER TABLE members
ADD status VARCHAR(20) DEFAULT 'Inactive'

UPDATE members
SET status = 'Active'
WHERE MembershipStartDate >= '2025-01-01'

SELECT full_name, MembershipStartDate, status
FROM members
--19) Delete members who never borrowed a book.
DELETE FROM members
WHERE NOT EXISTS (
    SELECT 1 
    FROM loan
    WHERE loan.M_ID = members.M_ID
)

SELECT * FROM members
 



 --------------------------------------------------Project 2
 -- Insert additional book records to ensure sufficient test data (minimum 20 books)
 INSERT INTO books (Book_ISBN, title, shelf_location, availability_status, price, genre, L_ID)
VALUES
('978-0006', 'Oman History', 'A3', 1, 28.00, 'Non-fiction', 1),
('978-0007', 'Desert Stories', 'B2', 1, 18.50, 'Fiction', 2),
('978-0008', 'Children Tales', 'B3', 1, 12.00, 'Children', 3),
('978-0009', 'SQL Advanced', 'A4', 1, 35.00, 'Reference', 1),
('978-0010', 'Science Today', 'D1', 1, 42.00, 'Non-fiction', 4),
('978-0011', 'Modern Oman', 'C1', 1, 30.00, 'Non-fiction', 5),
('978-0012', 'Fiction World', 'C2', 1, 22.50, 'Fiction', 2),
('978-0013', 'Kids Learning', 'B4', 1, 14.75, 'Children', 3),
('978-0014', 'Tech Basics', 'A5', 1, 27.00, 'Reference', 4),
('978-0015', 'Reference Guide', 'A6', 1, 33.00, 'Reference', 5),
('978-0016', 'Short Stories', 'C4', 1, 19.00, 'Fiction', 1),
('978-0017', 'Science for All', 'D2', 1, 38.00, 'Non-fiction', 2),
('978-0018', 'Oman Culture', 'C5', 1, 26.00, 'Non-fiction', 3),
('978-0019', 'Kids Fun', 'B5', 1, 11.50, 'Children', 4),
('978-0020', 'Digital World', 'A7', 1, 45.00, 'Reference', 5)

UPDATE books -- Update published_year for newly inserted books
SET published_year =
CASE 
    WHEN genre = 'Children' THEN 2018
    WHEN genre = 'Fiction' THEN 2019
    WHEN genre = 'Non-fiction' THEN 2020
    WHEN genre = 'Reference' THEN 2021
END
WHERE published_year IS NULL

--- Insert member records to ensure sufficient test data (minimum 10 members)
INSERT INTO members (full_name, email, phone_number, MembershipStartDate)
VALUES
('Saeed Al Balushi', 'saeed@oman.com', '91230001', '2024-01-10'),
('Maryam Al Hinai', 'maryam@oman.com', '91230002', '2024-02-15'),
('Khalid Al Amri', 'khalid@oman.com', '91230003', '2024-03-20'),
('Noor Al Rashdi', 'noor@oman.com', '91230004', '2024-04-18'),
('Salem Al Kathiri', 'salem@oman.com', '91230005', '2024-05-22')
select * from members

-- Insert loan values
INSERT INTO loan (loan_date, Due_Date, return_date, status, M_ID, B_ID)
VALUES
('2025-11-10', '2025-11-24', '2025-11-23', 'Returned', 8, 1),
('2025-11-12', '2025-11-26', NULL, 'Overdue', 9, 2),
('2025-11-15', '2025-11-29', NULL, 'Issued', 11, 3),
('2025-11-16', '2025-11-30', NULL, 'Issued', 10, 4),
('2025-11-18', '2025-12-02', NULL, 'Issued', 409, 5),
('2025-11-20', '2025-12-04', NULL, 'Issued', 408, 1011),
('2025-11-21', '2025-12-05', NULL, 'Issued', 407, 1018),
('2025-11-23', '2025-12-07', NULL, 'Issued', 12, 1017),
('2025-11-25', '2025-12-09', NULL, 'Issued', 8, 1015),
('2025-11-27', '2025-12-11', NULL, 'Issued', 10, 2)
SELECT * FROM members -- to check
SELECT * FROM loan


--Section 1: Complex Queries with Joins 
--1. Library Book Inventory Report
--Display library name, total number of books, number of available books, and number of 
--books currently on loan for each library. 
select 
l.L_name as  libraryName,
count(b.B_ID) as totalBooks,
sum(case when b.availability_status=1 then 1 else 0 end) as  numberOfAvailableBooks,
SUM(CASE 
            WHEN n.status = 'Issued' THEN 1 
            ELSE 0 
        END) AS Books_On_Loan
from librarys l
join books b
on l.L_ID=b.L_ID
join loan n
on b.B_ID=n.B_ID
group by l.L_name

select * from books

--2. Active Borrowers Analysis
--List all members who currently have books on loan (status = 'Issued' or 'Overdue'). Show 
--member name, email, book title, loan date, due date, and current status. 
select
m.full_name as memberName,
m.email as email,
b.title as bookTitle,
l.loan_date as loanDate,
l.Due_Date as duedate,
 l.status AS Current_Status
from members m
join loan l
on m.M_ID=l.M_ID
join books b
on b.B_ID=l.B_ID
WHERE l.status IN ('Issued','Overdue')

--3. Overdue Loans with Member Details 
--Retrieve all overdue loans showing member name, phone number, book title, library 
--name, days overdue (calculated as difference between current date and due date), and 
--any fines paid for that loan. 
select 
m.full_name as memberName,
m.phone_number as phoneMumber,
b.title as bookTitle,
l.L_name as libraryName,
datediff(day,n.loan_date,Due_Date) as daysOverdue,
 ISNULL(p.amount, 0) AS Fines_Paid
from members m
 join loan n
On m.M_ID=n.M_ID
 join books b
on n.B_ID=b.B_ID
 join librarys l
On b.L_ID=l.L_ID
LEFT join Payments p
ON n.loan_ID=p.loan_ID
WHERE n.status  ='Overdue'

--4. Staff Performance Overview 
--For each library, show the library name, staff member names, their positions, and count 
--of books managed at that library.
select 
l.L_name as  libraryName,
s.full_name as staffName,
s.position as staffpositions,
count(b.B_ID) as countOfBooks
 from Staff s
INNER join  librarys l
 ON l.L_ID=s.L_ID
LEFT  join books b
ON  l.L_ID=b.L_ID
group by l.L_name, s.full_name, s.position
 select * from books
 select * from Staff
 

 --5. Book Popularity Report 
--Display books that have been loaned at least 3 times. Include book title, ISBN, genre, 
--total number of times loaned, and average review rating (if any reviews exist). 
select
b.title as bookTitle,
b.Book_ISBN as Book_ISBN,
b.genre as genre,
count(n.loan_ID) as total_Loaned,
avg(r.rating) as average_rating
from books b
 join loan n
ON b.B_ID=n.B_ID
left join review r
ON n.B_ID=r.B_ID
group by b.title,
b.Book_ISBN,b.genre
having count(n.loan_ID) >= 3

--6. Member Reading History 
--Create a query that shows each member's complete borrowing history including: 
--member name, book titles borrowed (including currently borrowed and previously 
--returned), loan dates, return dates, and any reviews they left for those books. 
select 
m.full_name as memberName,
b.title as bookTitle,
n.loan_date as loanDate,
n.return_date as return_date,
r.rating as rating,
r.comments as comments
from members m
join loan n
On m.M_ID=n.M_ID
join books b
on n.B_ID=b.B_ID
left join review r
ON m.M_ID = r.M_ID
   and b.B_ID=r.B_ID 



--7. Revenue Analysis by Genre 
--Calculate total fine payments collected for each book genre. Show genre name, total 
--number of loans for that genre, total fine amount collected, and average fine per loan.
select 
b.genre as genreName,
count(n.loan_ID) as countloan,
SUM(ISNULL(p.amount, 0)) AS total_fine,
    AVG(ISNULL(p.amount, 0)) AS average_fine
from books b
left join loan n
ON b.B_ID=n.B_ID
left join Payments p
ON n.loan_ID=p.loan_ID
group by b.genre 

--------------------------------------Section 2: Aggregate Functions and Grouping
