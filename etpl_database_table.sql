-- Prepares a MySQL server for the project.
CREATE DATABASE IF NOT EXISTS etpl_dev_db;
CREATE USER IF NOT EXISTS 'etpl_dev'@'localhost' IDENTIFIED BY 'etpl_dev_pwd';
GRANT ALL PRIVILEGES ON etpl_dev_db . * TO 'etpl_dev'@'localhost';
GRANT SELECT ON performance_schema . * TO 'etpl_dev'@'localhost';
FLUSH PRIVILEGES;

USE etpl_dev_db;

--
-- Create a table named `properties` in etpl_dev_db MySQL database:
--

DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
     id INT AUTO_INCREMENT PRIMARY KEY,
     name VARCHAR(255) NOT NULL,
     location VARCHAR(255) NOT NULL,
     types VARCHAR(50) NOT NULL
     );

--
-- Populate the table with some sample data:
--

LOCK TABLES properties WRITE;

INSERT INTO properties (name, location, types) VALUES ('Ayat R_estate', 'Addis Ababa', 'Apartments G+Villas'),
                                                              ('Gift R_estate', 'Addis Ababa', 'Apartments G+Villas'),
                                                              ('Flintstone Homes', 'Addis Ababa', 'Apartments G+Villas'),
                                                              ('Noah R_estate', 'Addis Ababa', 'Apartments'),
                                                              ('Metropolitain R_estate', 'Addis Ababa', 'Apartments G+Villas'),
                                                              ('Platinum R_estate', 'Addis Ababa', 'Apartments Towers'),
                                                              ('Evergrand R_estate', 'Addis Ababa', 'Apartments G+Villas'),
                                                              ('La Gare', 'Addis Ababa', 'Apartments G+Villas'),
                                                              ('Yaya R_estate', 'Addis Ababa', 'Apartments G+Villas'),
                                                              ('Betopia Properties', 'Addis Ababa', 'Apartments G+Villas');
