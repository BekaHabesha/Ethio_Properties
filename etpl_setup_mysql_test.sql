-- Prepares a MySQL Test server for the project.
CREATE DATABASE IF NOT EXISTS etpl_test_db;
CREATE USER IF NOT EXISTS 'etpl_test'@'localhost' IDENTIFIED BY 'etpl_test_pwd';
GRANT ALL PRIVILEGES ON etpl_test_db . * TO 'etpl_test'@'localhost';
GRANT SELECT ON performance_schema . * TO 'etpl_test'@'localhost';
