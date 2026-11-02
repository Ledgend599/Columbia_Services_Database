USE columbia_services_db;


-- Test source
INSERT INTO Source
    (publisher, title, url, access_date, raw_file, reuse_note)
VALUES
    ('T4 Test Publisher',
     'T4 Test Source',
     'https://example.com/t4-test-source',
     '2026-10-04',
     'T4 fixture',
     'Temporary fixture for T4 testing');

SET @t4_source_id = LAST_INSERT_ID();

-- Test category
INSERT INTO Service_Category
    (category_name)
VALUES
    ('T4 Test Category');

SET @t4_category_id = LAST_INSERT_ID();

-- Test services
INSERT INTO Service
    (category_id, service_name)
VALUES
    (@t4_category_id, 'T4 Service A'),
    (@t4_category_id, 'T4 Service B');

SET @t4_service_a = LAST_INSERT_ID();

-- Get Service b's ID
SELECT service_id
INTO @t4_service_b
FROM Service
WHERE service_name = 'T4 Service B';

-- Test businesses
INSERT INTO Business
    (business_name, street_address, city, state,
     postal_code, website, source_id, raw_row_id)
VALUES
    ('T4 Test Business A',
     '100 T4 Test St',
     'Columbia',
     'MO',
     '65201',
     NULL,
     @t4_source_id,
     9001),

    ('T4 Test Business B',
     '200 T4 Test St',
     'Columbia',
     'MO',
     '65201',
     'https://example.com/t4-business-b',
     @t4_source_id,
     9002);

SET @t4_business_a = LAST_INSERT_ID();

SELECT business_id
INTO @t4_business_b
FROM Business
WHERE business_name = 'T4 Test Business B';

INSERT INTO Business_Service
    (business_id, service_id, source_id, raw_row_id)
VALUES
    (@t4_business_a, @t4_service_a, @t4_source_id, 9001);

INSERT INTO Business_Service
    (business_id, service_id, source_id, raw_row_id)
VALUES
    (@t4_business_b, @t4_service_a, @t4_source_id, 9002);

SELECT
    s.service_id,
    s.service_name,
    COUNT(DISTINCT bs.business_id) AS provider_count
FROM Service AS s
JOIN Business_Service AS bs
    ON s.service_id = bs.service_id
WHERE s.service_id = @t4_service_a
GROUP BY s.service_id, s.service_name
HAVING COUNT(DISTINCT bs.business_id) >= 2;

SELECT
    b.business_id,
    b.business_name,
    b.city
FROM Business AS b
WHERE b.business_id = @t4_business_a
  AND NOT EXISTS (
      SELECT 1
      FROM Business_Service AS bs
      JOIN Service AS s
          ON bs.service_id = s.service_id
      WHERE bs.business_id = b.business_id
        AND s.service_id = @t4_service_b
  );

SELECT
    s.service_id,
    s.service_name,
    bs.business_id
FROM Service AS s
LEFT JOIN Business_Service AS bs
    ON s.service_id = bs.service_id
    AND bs.business_id = @t4_business_a
WHERE s.service_id IN (@t4_service_a, @t4_service_b)
ORDER BY s.service_id;

SELECT
    business_id,
    business_name,
    city,
    website
FROM view_business_directory
WHERE business_id = @t4_business_a
  AND website IS NULL
ORDER BY city, business_name, business_id;

DELETE FROM Business_Service
WHERE source_id = @t4_source_id;

DELETE FROM Business
WHERE source_id = @t4_source_id;

DELETE FROM Service
WHERE category_id = @t4_category_id;

DELETE FROM Service_Category
WHERE category_id = @t4_category_id;

DELETE FROM Source
WHERE source_id = @t4_source_id;