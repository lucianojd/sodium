DROP DATABASE IF EXISTS east_blue;
CREATE DATABASE east_blue;

USE east_blue;

 -- Create and load data into users table.
CREATE TABLE user(
  id INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(64),
  password VARCHAR(128),
  first_name VARCHAR(32),
  last_name VARCHAR(32),
  phone_number VARCHAR(16),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
);

LOAD DATA INFILE '/var/lib/mysql-files/user.csv'
INTO TABLE user
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(email, password, first_name, last_name, phone_number);

-- Create and load data into the locations table.

CREATE TABLE locations(
  id INT NOT NULL AUTO_INCREMENT,
  country VARCHAR(32),
  city VARCHAR(32),
  province VARCHAR(32),
  lat FLOAT NOT NULL,
  lon FLOAT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
);

LOAD DATA INFILE '/var/lib/mysql-files/locations.csv'
INTO TABLE locations
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(country, city, province, lat, lon);

-- Create and load data into the events table.

CREATE TABLE events(
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(64),
  owner_id INT,
  location_id INT,
  cancelled BOOLEAN NOT NULL,
  contact_phone VARCHAR(32),
  contact_email VARCHAR(32),
  website VARCHAR(64),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY(location_id)
    REFERENCES locations(id),
  FOREIGN KEY(owner_id)
    REFERENCES user(id)
);

LOAD DATA INFILE '/var/lib/mysql-files/events.csv'
INTO TABLE events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(title,owner_id,location_id,cancelled,contact_phone,contact_email,website);

-- Create and load data into the favorite_events table.

CREATE TABLE favorite_events(
  user_id INT NOT NULL,
  FOREIGN KEY (user_id)
    REFERENCES user(id),
  event_id INT NOT NULL,
  FOREIGN KEY (event_id)
    REFERENCES events(id),
  PRIMARY KEY(user_id, event_id)
);

LOAD DATA INFILE '/var/lib/mysql-files/favorite_events.csv'
INTO TABLE favorite_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(user_id, event_id);