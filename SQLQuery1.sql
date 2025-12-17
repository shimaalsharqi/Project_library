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
('2025-12-12', 30.00, 'Card', 5);

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
