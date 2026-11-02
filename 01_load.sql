-- 01_load.sql
-- using the Raw Observations and the database created in 00_schema.sql

USE columbia_services_db;

-- Inserting the Sources 
INSERT INTO Source (source_id, publisher, title, url, access_date, raw_file, reuse_note) VALUES
(1, 'The Loop Como', 'Auto Business Category', 'https://theloopcomo.com/category/business/auto/', '2026-10-04', 'data_collection/raw_data.csv', NULL),
(2, 'Chamber of Commerce', 'Columbia Auto Repair Directory', 'https://www.chamberofcommerce.com/business-directory/missouri/columbia/auto-repair-shop/', '2026-10-04', 'data_collection/raw_data.csv', NULL),
(3, 'Loc8NearMe', 'Columbia MO Business Directory', 'https://www.loc8nearme.com/missouri/columbia/', '2026-10-04', 'data_collection/raw_data.csv', NULL),
(4, 'Mizzou ISSS', 'Food Stores Near Campus', 'https://international.missouri.edu/isss/living-in-columbia/daily-life/food-stores-near-campus/', '2026-10-04', 'data_collection/raw_data.csv', NULL),
(5, 'FindGlocal', 'Go-Fresco Page', 'https://www.findglocal.com/US/Columbia/106459240804135/Go---Fresco', '2026-10-04', 'data_collection/raw_data.csv', NULL),
(6, 'A&Y Global Market', 'A&Y Global Market', 'https://www.ayglobalmarket.store/', '2026-10-04', 'data_collection/raw_data.csv', NULL),
(7, 'Firestone Complete Auto Care', 'Firestone Complete Auto Care - Columbia, MO', 'https://www.firestonecompleteautocare.com/missouri/columbia/703-business-loop-70-w/', '2026-10-04', 'data_collection/raw_data.csv', NULL),
(8, 'Midas', 'Midas - Columbia, MO', 'https://www.midas.com/store/mo/columbia/1201-business-loop-70-east-65201?shopnum=5750', '2026-10-04', 'data_collection/raw_data.csv', NULL),
(9, 'Plaza Tire Service', 'Plaza Tire Service', 'https://www.plazatireservice.com/', '2026-10-04', 'data_collection/raw_data.csv', NULL),
(10, 'Walt''s Service Inc.', 'Walt''s Service Inc.', 'https://www.waltsserviceinc.net/', '2026-10-04', 'data_collection/raw_data.csv', NULL),
(11, 'Norris Full Service Auto', 'Norris Full Service Auto', 'https://norrisfullserviceauto.com/', '2026-10-04', 'data_collection/raw_data.csv', NULL),
(12, 'Dobbs Tire & Auto Centers', 'Dobbs Tire & Auto Centers - Nifong Blvd Columbia', 'https://www.gotodobbs.com/locations/nifong-blvd-columbia/', '2026-10-04', 'data_collection/raw_data.csv', NULL),
(13, 'Automotive Specialist', 'Automotive Specialist', 'https://www.automotivespecialistmo.com/', '2026-10-04', 'data_collection/raw_data.csv', NULL),
(14, 'A-Z Auto Repair', 'A-Z Auto Repair', 'https://www.atozautorepaircolumbia.com/', '2026-10-04', 'data_collection/raw_data.csv', NULL);

-- Inserting the Service Categories (2 categories)
INSERT INTO Service_Category (category_id, category_name) VALUES
(1, 'Automotive'),
(2, 'Specialty Markets');

-- Inserting the Services (4 Service Types)
INSERT INTO Service (service_id, category_id, service_name) VALUES
(1, 1, 'Oil and filter change and vehicle inspection'),
(2, 1, 'Muffler and exhaust system inspection and service'),
(3, 2, 'Imported Packaged Groceries'),
(4, 2, 'In-store fresh food and deli counter');

-- Inserting 15 Businesses
INSERT INTO Business (business_id, business_name, street_address, city, state, postal_code, website, source_id, raw_row_id) VALUES
(1, 'A - Z Auto Repair', '1001 Business Loop 70 E', 'Columbia', 'MO', '65201', 'https://www.atozautorepaircolumbia.com/', 14, 1),
(2, 'Firestone Complete Auto Care', '703 Business Loop 70 W', 'Columbia', 'MO', '65203', 'https://www.firestonecompleteautocare.com/missouri/columbia/703-business-loop-70-w/', 7, 2),
(3, 'Midas Muffler Shop', '1201 Business Loop 70 E', 'Columbia', 'MO', '65201', 'https://www.midas.com/store/mo/columbia/1201-business-loop-70-east-65201?shopnum=5750', 8, 3),
(4, 'Plaza Tire Service', '806 Smiley Ln', 'Columbia', 'MO', '65202', 'https://www.plazatireservice.com/', 9, 4),
(5, 'Walts Inc.', '1204 N College Ave', 'Columbia', 'MO', '65201', 'https://www.waltsserviceinc.net/', 10, 5),
(6, 'Norris Full Service Auto', '2100 W Rollins Rd', 'Columbia', 'MO', '65203', 'https://norrisfullserviceauto.com/', 11, 6),
(7, 'Dobbs Tire & Auto Centers', '606 East Nifong Boulevard', 'Columbia', 'MO', '65201', 'https://www.gotodobbs.com/locations/nifong-blvd-columbia/', 12, 7),
(8, 'Automotive Specialist', '1201 Old 63 N', 'Columbia', 'MO', '65201', 'https://www.automotivespecialistmo.com/', 13, 8),
(9, 'A&Y Global Market', '400 Business Loop 70 W', 'Columbia', 'MO', '65201', 'https://www.ayglobalmarket.store/', 4, 9),
(10, 'African Market', '1004 Old 63 N', 'Columbia', 'MO', '65201', NULL, 4, 10),
(11, 'Go-Fresco', '3605 S Providence Road, Suite 6', 'Columbia', 'MO', '65203', NULL, 4, 11),
(12, 'Iyumva International Market', '705 Vandiver Drive, Suite K', 'Columbia', 'MO', '65202', NULL, 4, 12),
(13, 'Sai Market', '2101 W Broadway', 'Columbia', 'MO', '65203', NULL, 4, 13),
(14, 'Shwe Market International Foods', '800 Vandiver Drive', 'Columbia', 'MO', '65202', NULL, 4, 14),
(15, 'Tienda EL PATRON', '711 Vandiver Drive, Suite G', 'Columbia', 'MO', '65202', NULL, 4, 15);

-- Inserting 20 Business-Service Offerings
INSERT INTO Business_Service (business_id, service_id, source_id, raw_row_id) VALUES
-- Automotive Offerings (11 total)
(1, 1, 14, 1),  -- A-Z Auto (Oil & Inspection)
(2, 1, 7, 2),  -- Firestone (Oil & Inspection)
(3, 1, 8, 3),  -- Midas (Oil & Inspection)
(3, 2, 8, 3),  -- Midas (Muffler & Exhaust)
(4, 1, 9, 4),  -- Plaza Tire (Oil & Inspection)
(5, 1, 10, 5),  -- Walts Inc. (Oil & Inspection)
(6, 1, 11, 6),  -- Norris Full Service Auto (Oil & Inspection)
(6, 2, 11, 6),  -- Norris Full Service Auto (Muffler & Exhaust: raw row 6 says 'Exhaust Systems and Mufflers')
(7, 1, 12, 7),  -- Dobbs Tire (Oil & Inspection)
(8, 1, 13, 8),  -- Automotive Specialist (Oil & Inspection)
(8, 2, 13, 8),  -- Automotive Specialist (Muffler & Exhaust)

-- Specialty Market Offerings (9 total)
(9, 3, 4, 9),   -- A&Y Global (Imported Packaged Groceries)
(9, 4, 4, 9),   -- A&Y Global (Fresh Food & Deli)
(10, 3, 4, 10), -- African Market (Imported Packaged Groceries)
(11, 3, 4, 11), -- Go-Fresco (Imported Packaged Groceries)
(12, 3, 4, 12), -- Iyumva (Imported Packaged Groceries)
(13, 3, 4, 13), -- Sai Market (Imported Packaged Groceries)
(14, 3, 4, 14), -- Shwe Market (Imported Packaged Groceries)
(15, 3, 4, 15), -- Tienda EL PATRON (Imported Packaged Groceries)
(15, 4, 4, 15); -- Tienda EL PATRON (Fresh Food & Deli)
