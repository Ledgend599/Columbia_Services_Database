-- 03_queries.sql 
USE columbia_services_db;
-- Q1: Which businesses match a name fragment?
-- Parameter: name fragment = 'Auto'
-- Output: business ID, name, and city for each business whose name contains 'Auto'.
-- Check: expect 5 rows (IDs 1, 2, 6, 7, 8). Other auto shops (e.g., Midas, Plaza Tire,
--        Walts) do not contain 'Auto' in their names, so they correctly do not match.

SELECT
    business_id,
    business_name,
    city
FROM Business
WHERE business_name LIKE '%Auto%'
ORDER BY business_id, business_name;

-- Q2: Which businesses in a city have a recorded offering for a service?
-- Parameters: city = 'Columbia', service = 'Oil and filter change and vehicle inspection'
-- Output: provider, service, source URL, and raw-row reference for each offering.
-- Limitation: each business has one selected location; the source supports a business-level
--             offering, so branch availability is unverified.
-- Check: expect one row per business with this offering, no duplicates (currently 8;
--        matches the 8 Oil rows in Business_Service).
SELECT DISTINCT
    b.business_id,
    b.business_name,
    b.city,
    s.service_name,
    src.url AS source_url,
    bs.raw_row_id
FROM Business AS b
JOIN Business_Service AS bs
    ON b.business_id = bs.business_id
JOIN Service AS s
    ON bs.service_id = s.service_id
JOIN Source AS src
    ON bs.source_id = src.source_id
WHERE b.city = 'Columbia'
  AND s.service_name = 'Oil and filter change and vehicle inspection'
ORDER BY b.business_name, b.business_id;

-- Q3: Which services have at least a chosen number of providers?
-- Parameter: threshold = 3 providers
-- Output: service name and number of distinct providers.
-- Check: expect 3 rows (oil/inspection 8, imported groceries 7, muffler/exhaust 3);
--        the deli service has only 2 providers, so it is excluded.
SELECT
    s.service_id,
    s.service_name,
    COUNT(DISTINCT bs.business_id) AS provider_count
FROM Service AS s
JOIN Business_Service AS bs
    ON s.service_id = bs.service_id
GROUP BY
    s.service_id,
    s.service_name
HAVING COUNT(DISTINCT bs.business_id) >= 3
ORDER BY
    provider_count DESC,
    s.service_name;

-- Q4: Which businesses have no recorded offering for a service?
-- Parameter: service = 'Oil and filter change and vehicle inspection'
-- Output: ID, name, and city of businesses with no such recorded offering.
-- Interpretation: absence means "not recorded in our data," not proof the business lacks it.
-- Check: expect 7 rows (IDs 9-15, the specialty markets) = 15 businesses - 8 oil providers.
SELECT
    b.business_id,
    b.business_name,
    b.city
FROM Business AS b
WHERE NOT EXISTS (
    SELECT 1
    FROM Business_Service AS bs
    JOIN Service AS s
        ON bs.service_id = s.service_id
    WHERE bs.business_id = b.business_id
      AND s.service_name =
          'Oil and filter change and vehicle inspection'
)
ORDER BY
    b.business_name,
    b.business_id;

-- Q5: For one business, list every service type and the matched business ID (NULL if none).
-- Parameter: business_id = 1 (A - Z Auto Repair)
-- Output: all 4 services; business_id is 1 where recorded, NULL otherwise.
-- Note: the business condition is in the ON clause so unmatched services are kept.
-- Check: expect 4 rows; only service 1 shows 1, services 2-4 show NULL.
SELECT
    s.service_id,
    s.service_name,
    bs.business_id
FROM Service AS s
LEFT JOIN Business_Service AS bs
    ON s.service_id = bs.service_id
    AND bs.business_id = 1
ORDER BY
    s.service_id;

-- Q6: Which businesses in the directory view have no recorded website?
-- Parameters: none (uses view_business_directory from 02_view.sql)
-- Output: ID, name, city, and website (NULL) for businesses without a website.
-- Check: expect 6 rows (IDs 10-15); NULL = no own website found, not proof none exists.
SELECT
    business_id,
    business_name,
    city,
    website
FROM view_business_directory
WHERE website IS NULL
ORDER BY
    city,
    business_name,
    business_id;