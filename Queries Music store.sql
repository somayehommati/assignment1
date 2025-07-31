SELECT  * FROM Customers LIMIT 5;
SELECT title , release_date FROM songs WHERE release_date='2022' ORDER BY release_date DESC ;   
SELECT popularity_score, duration_seconds  FROM songs s WHERE popularity_score >80 AND duration_seconds<240 ;
SELECT artist_name  FROM artists where artist_name LIKE 'The%';
SELECT is_premium_member FROM  customers WHERE is_premium_member=1  AND join_date='2022';
SELECT SUM(duration_seconds)/60 AS Total_duration_mins FROM songs;
SELECT song_id , price FROM Purchases ORDER BY price DESC LIMIT 5;

SELECT * FROM Purchases WHERE song_id in (SELECT song_id FROM songs WHERE popularity_score>90) ;
SELECT * FROM Purchases WHERE purchase_date BETWEEN '2023-01-01' and '2023-03-31';
SELECT * FROM songs WHERE popularity_score >90;



---1-Reduced Redundancy: Separate tables avoid storing the same information multiple times
---and prevent errors and it can makes better queries.
---2-to determine how artists can affect on particular ages
---3-we can extend  existing schema by adding new tables and columns to track this information for example user behavior table
---4-select * from songs where artist_id in(select artist_id  from songs where duration_seconds order by duration_songs ASC LIMIT 5 )