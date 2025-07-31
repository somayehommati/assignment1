CREATE TABLE Artists (
    artist_id INT PRIMARY KEY ,
    artist_name varchar(100) NOT NULL,
    genre varchar(50),
    country varchar(50),
    active_since varchar(50)
);
CREATE TABLE songs (
    song_id INT PRIMARY KEY ,
    title varchar(100) NOT NULL,
    album varchar(50),
    release_date DATE,
    duration_seconds INT,
    popularity_score INT,
    artist_id INT ,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);
PRAGMA foreign_keys = ON;


CREATE TABLE Purchases (
    purchase_id INT PRIMARY KEY ,
    purchase_date DATE,
    price decimal,
    customer_id INT,
    song_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
    );

CREATE TABLE Streams (
    stream_id INT PRIMARY KEY ,
    stream_date DATE,
    stream_time TIME ,
    customer_id INT,
    song_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
    );
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY ,
    first_name varchar(100) NOT NULL,
    last _name varchar(100),
    remail varchar(100),
    join_date DATE,
    is_premium_member INT DEFAULT 0 CHECK (is_premium_member IN(0,1) )
    );