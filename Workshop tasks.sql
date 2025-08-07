--1.Basic Selection:
SELECT 
title, publication_year   
FROM Books 
WHERE publication_year  > 2000
ORDER BY publication_year ASC ;

--2.Filtering
SELECT 
title,book_id ,copies_owned 
FROM Books 
WHERE copies_owned > 5 AND  genre_id = 1 ;

--3.Pattern Matching:
SELECT 
title
FROM Books 
WHERE title LIKE '%History%' ;

--4.JOIN Operations
SELECT 
loan_id, checkout_date,due_date, first_name, last_name,email
FROM Loans 
INNER JOIN Patrons ON Loans.patron_id = Patrons.patron_id 
WHERE checkout_date > '2023-01';

--5.Multi-table JOIN:
SELECT 
Books.title,
Authors.first_name, Authors.last_name,
Genres.genre_name,
Loans.checkout_date,Loans.due_date l
FROM Loans  
INNER JOIN Books ON Loans.book_id= Books.book_id 
INNER JOIN Authors  ON Books.author_id = Authors.author_id 
INNER JOIN Genres  ON Books.genre_id= Genres.genre_id ;

--6.Self JOIN:
SELECT
  P1.last_name  AS Patron1Name,
  P2.last_name  AS Patron2Name,
  P1.city 
FROM
  Patrons AS P1
JOIN
  Patrons AS P2 ON P1.city = P2.city  AND P1.patron_id  <> P2.patron_id 
ORDER BY
  P1.city , P1.last_name , P2.last_name;


--7.Multi-table JOIN with filtering: 
SELECT 
Books.title,
Patrons.last_name,
Branches.branch_name
FROM Books 
INNER JOIN Genres  ON Books.genre_id= Genres.genre_id 
INNER JOIN Loans  ON Books.book_id  = Loans.book_id 
INNER JOIN Patrons   ON Loans.patron_id = Patrons.patron_id 
INNER JOIN Branches ON Loans.branch_id =Branches.branch_id 
WHERE 
Genres.genre_id = 1 ;

--8.COUNT aggregation: 
SELECT 
genre_id ,
COUNT(*) AS book_counts FROM  Books GROUP BY genre_id  ;

--9.Multiple aggregations:
SELECT
Branches.branch_name,
AVG(JULIANDAY(Loans.return_date) - JULIANDAY(Loans.checkout_date)) AS average_days,
MIN(JULIANDAY(Loans.return_date) - JULIANDAY(Loans.checkout_date)) AS min_days,
MAX(JULIANDAY(Loans.return_date) - JULIANDAY(Loans.checkout_date)) AS max_days
FROM Loans 
INNER JOIN branches ON Loans.branch_id = Branches.branch_id
WHERE Loans.return_date IS NOT NULL
GROUP BY Branches.branch_name;

--10.Conditional aggregation: 
SELECT
    last_name,
    COUNT( Loans.due_date < date('now') AND Loans.return_date IS NULL) AS Overdue_books
FROM
    Patrons 
INNER JOIN Loans ON Patrons.patron_id = Loans.patron_id
GROUP BY last_name 
HAVING Overdue_books > 0;

--11.Time-based analysis:
SELECT 
Books.title AS Trend_book,
Loans.checkout_date ,
COUNT(*) AS loan_count ,
COUNT(DISTINCT patron_id) AS Unique_patrons
FROM Loans 
INNER JOIN Books ON Loans.book_id = Books.book_id 
GROUP BY 
Books.title 
ORDER BY
Loans.checkout_date;
--Discussion Questions:
-- 1--Instead of just indicating that a book can exist at a branch, we quantify how many copies of
-- a given book are physically present at each branch. When a book is borrowed or returned, the quantity in
-- the BookInventory table for the relevant book_id and branch_id would be decremented or incremented accordingly.
-- 2--which author is more popular in library and which genre is its book?--what ages group are more active to borrow books?
-- which season of the year is incountering with high volume of borrowing and why?
-- 3-- we have to add new tables to manage new requirements  Reserved Book table to check reserved books , Late fees table for charges given for overdue books ,
-- and Library programs table for define programs and link patrons to the participating programs.
-- 4-- We can add a column in Books table with name book_copies_number and 
---select title, genre,publication_year,book_copies_number from books where genre ='History'
-- group by publication_year DESC limit 5
-- 5 --Using indexed columns in queries to get data quickly avoiding full table scanning.
-- use queries with less data and avoid to use SELECT *