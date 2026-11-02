-- 02_view.sql
-- using the same database
USE columbia_services_db;
DROP VIEW IF EXISTS view_business_directory;

CREATE OR REPLACE VIEW view_business_directory AS
SELECT b.business_id,
       b.business_name,
       b.street_address,
       b.city,
       b.state,
       b.postal_code,
       b.website,                      -- NULL = no own website found
       b.source_id  AS identity_source_id,
       s.url        AS identity_source_url,
       b.raw_row_id
FROM Business AS b
JOIN Source   AS s ON s.source_id = b.source_id;