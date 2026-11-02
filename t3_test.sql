USE columbia_services_db;

-- fails because of duplicate entry for PRIMARY key
INSERT INTO Business_Service (business_id, service_id, source_id, raw_row_id)
VALUES (1, 1, 1, 8888);