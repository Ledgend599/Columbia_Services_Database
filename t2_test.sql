USE columbia_services_db;

-- fails because of foreign key constraint 
INSERT INTO Business_Service (business_id, service_id, source_id, raw_row_id)
VALUES (999, 1, 1, 9999);