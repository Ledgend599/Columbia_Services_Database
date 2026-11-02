-- 00_schema.sql
DROP DATABASE IF EXISTS columbia_services_db; -- added because while editing these it kept on causing error because the database was already made
CREATE DATABASE columbia_services_db;
USE columbia_services_db;
-- Note: Deletion behavior: all foreign keys use MySQL's default (RESTRICT).
-- A parent row (Source, Business, Service, Service_Category) cannot be deleted while child rows reference it, so offerings never lose their business, service, or source. Delete child rows first.


-- all of these are based on the ER model
-- for the Source Table
CREATE TABLE Source (
    source_id INT AUTO_INCREMENT PRIMARY KEY, -- I googled this so we can automatically have the id as it is self asssigned
    publisher VARCHAR(200) NOT NULL,
    title VARCHAR(200) NOT NULL,
    url VARCHAR(200) NOT NULL UNIQUE,
    access_date DATE NOT NULL,
    raw_file VARCHAR(200) NOT NULL,
    reuse_note VARCHAR(200) NULL
);

-- for the Business Table
CREATE TABLE Business (
    business_id INT AUTO_INCREMENT PRIMARY KEY,
    business_name VARCHAR(255) NOT NULL UNIQUE,
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL DEFAULT 'Columbia', -- setting default columbia because the search is for there
    state VARCHAR(50) NOT NULL DEFAULT 'MO',
    postal_code VARCHAR(20),
    website VARCHAR(255),
    source_id INT NOT NULL,
    raw_row_id INT NOT NULL,
    FOREIGN KEY (source_id) REFERENCES Source(source_id)
);

-- for the Service Category Table
CREATE TABLE Service_Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- for the Service Table
CREATE TABLE Service (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    service_name VARCHAR(150) NOT NULL UNIQUE,
    FOREIGN KEY (category_id) REFERENCES Service_Category(category_id)
);

-- for the Business_Service Table (Associative Table)
CREATE TABLE Business_Service (
    business_id INT NOT NULL,
    service_id INT NOT NULL,
    source_id INT NOT NULL,
    raw_row_id INT NOT NULL,
    PRIMARY KEY (business_id, service_id),
    FOREIGN KEY (business_id) REFERENCES Business(business_id),
    FOREIGN KEY (service_id) REFERENCES Service(service_id),
    FOREIGN KEY (source_id) REFERENCES Source(source_id)
);