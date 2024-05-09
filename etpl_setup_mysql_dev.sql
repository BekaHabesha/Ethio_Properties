-- Prepares a MySQL server for the project.
CREATE DATABASE IF NOT EXISTS etpl_dev_db;
CREATE USER IF NOT EXISTS 'etpl_dev'@'localhost' IDENTIFIED BY 'etpl_dev_pwd';
GRANT ALL PRIVILEGES ON etpl_dev_db . * TO 'etpl_dev'@'localhost';
GRANT SELECT ON performance_schema . * TO 'etpl_dev'@'localhost';
FLUSH PRIVILEGES;
