-- Database schema for h4g project
-- Run this SQL script in phpMyAdmin or MySQL command line to create the database and table

-- Create database
CREATE DATABASE IF NOT EXISTS h4g_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Use the database
USE h4g_db;

-- Create data table
CREATE TABLE IF NOT EXISTS data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    keyword VARCHAR(255) NOT NULL,
    flag VARCHAR(50) NOT NULL,
    INDEX idx_keyword (keyword)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

