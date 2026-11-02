USE columbia_services_db;
-- T 1.1 15 businesses
SELECT
    COUNT(*) AS business_count,
    CASE
        WHEN COUNT(*) >= 15 THEN 'PASS'
        ELSE 'FAIL'
    END AS result
FROM Business;

-- T 1.2 At least 4 services
SELECT
    COUNT(*) AS service_count,
    CASE
        WHEN COUNT(*) >= 4 THEN 'PASS'
        ELSE 'FAIL'
    END AS result
FROM Service;

-- T 1.3 at least 2 service categories
SELECT
    COUNT(*) AS category_count,
    CASE
        WHEN COUNT(*) >= 2 THEN 'PASS'
        ELSE 'FAIL'
    END AS result
FROM Service_Category;

-- T 1.4 at least 20 distinct business-service offerings
SELECT
    COUNT(*) AS offering_count,
    CASE
        WHEN COUNT(*) >= 20 THEN 'PASS'
        ELSE 'FAIL'
    END AS result
FROM (
    SELECT DISTINCT
        business_id,
        service_id
    FROM Business_Service
) AS offerings;

-- T 1.5 at least 2 publishers
SELECT
    COUNT(DISTINCT publisher) AS publisher_count,
    CASE
        WHEN COUNT(DISTINCT publisher) >= 2 THEN 'PASS'
        ELSE 'FAIL'
    END AS result
FROM Source;

-- T 1.6 business source references
SELECT
    COUNT(*) AS businesses_missing_source,
    CASE
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END AS result
FROM Business
WHERE source_id IS NULL;

-- T 1.7 business source urls
SELECT
    COUNT(*) AS businesses_missing_url,
    CASE
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END AS result
FROM Business AS b
JOIN Source AS src
    ON b.source_id = src.source_id
WHERE src.url IS NULL
   OR TRIM(src.url) = '';
   
-- T 1.8 offering source references
SELECT
    COUNT(*) AS offerings_missing_source,
    CASE
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END AS result
FROM Business_Service
WHERE source_id IS NULL;

-- T 1.9 offering source urls
SELECT
    COUNT(*) AS offerings_missing_url,
    CASE
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END AS result
FROM Business_Service AS bs
JOIN Source AS src
    ON bs.source_id = src.source_id
WHERE src.url IS NULL
   OR TRIM(src.url) = '';