Columbia Local Services Database



Team Members



\- Jonathan Greer

\- Samir Khanal

\- Ocean Panta



MySQL Version



MySQL Version: 8.0.47



The database was developed and tested using MySQL Workbench.



Run Commands



Run the SQL files in the following order:



1. 00\_schema.sql
2. 01\_load.sql
3. 02\_views.sql
4. 03\_queries.sql



Example (from the sql\_files folder, MySQL command line):

    mysql -u root -p < 00_schema.sql
    mysql -u root -p < 01_load.sql
    mysql -u root -p < 02_views.sql
    mysql -u root -p < 03_queries.sql

Tests (run after the build): t1_test.sql, t2_test.sql (expected error 1452), t3_test.sql (expected error 1062), t4_test.sql (self-cleaning fixture).



The scripts must be run in this order because the schema must be created before the data can be loaded, and the database and view must exist before the queries are executed.



The database created by the scripts is: columbia\_services\_db



Clean Rebuild



To rebuild the database from scratch, run 00\_schema.sql again. It drops the existing database with DROP DATABASE IF EXISTS before recreating all tables. Running the scripts a second time produces the same counts without duplicate accumulation. Verified: 15 businesses, 4 services, 2 categories, 20 offerings, 14 sources after a clean rebuild.



Table and Key Summary



Source

* Primary Key: source\_id
* Stores information about the sources used to collect business and service information.



Business

* Primary Key: business\_id
* Foreign Key: source\_id references Source(source\_id)
* Unique: business\_name
* Stores information about each business, including its name, address, website, source, and raw data row.



Service\_Category

* Primary Key: category\_id
* Stores the categories used to organize services.



Service

* Primary Key: service\_id
* Foreign Key: category\_id references Service\_Category(category\_id)
* Stores the individual services represented in the database.



Business\_Service

* Composite Primary Key: business\_id, service\_id
* Foreign Keys:
1. business\_id references Business(business\_id)
2. service\_id references Service(service\_id)
3. source\_id references Source(source\_id)



This associative table represents the many-to-many relationship between businesses and services.



File Locations



\- 00\_schema.sql — creates the database, tables, keys, and constraints. (delete constraint is mainitained by default through foreign key)

\- 01\_load.sql — loads the collected data into the database.

\- 02\_views.sql — creates the reusable view\_business\_directory view.

\- 03\_queries.sql — contains required queries Q1 through Q6.

\- t1\_test.sql — contains T1 count and source-link validation tests.

\- t2\_test.sql — contains T2 foreign key rejection test.

\- t3\_test.sql — contains T3 duplicate business-service rejection test.

\- t4\_test.sql — contains the isolated T4 fixture tests for Q3, Q4, Q5, and Q6.

\- query\_output.pdf — contains Q1 through Q6 screenshot outputs.

\- validation\_logs.txt — contains expected/actual test logs.

\- report.pdf — final project report (two pages of text plus one ER-diagram page).

\- raw\_data.csv — unchanged raw observations with raw-row IDs and source URLs.

\- sources.csv — source register with source IDs, publishers, URLs, and access dates.

\- rules.txt — cleaning note with two rules, three before/after examples, and counts.

\- corraboration.txt — corroboration note for three businesses checked against two independent publishers.

\- ER model MYSQL.pdf — MySQL Workbench reverse-engineered ER diagram.

\- Hand_traced ER Diagram — ER diagram with crow's foot notation.



&#x20;Contributions



&#x20;Jonathan Greer

\- Created and tested queries Q1 through Q6.

\- Completed T1 and T4 testing.

\- Maintained the test log (T1 and T4).

\- Completed README file

\- Helped edit and review the project report.

\- Performed final functionality checks and project packaging.



&#x20;Samir Khanal

\- Collected project data and source information.

\- Corroborated collected information.

\- Contributed to the project report.



&#x20;Ocean Panta

\- Coordinated group collaboration

\- Created the database design and ER diagram.

\- Created the schema, data-loading, and view SQL.

\- Completed T2 and T3 testing.

\- Maintained the test log (T2 and T3).

\- Worked on normalization examples and database constraints (four business rules).

\- Contributed to and finalized the project report.



&#x20;AI Use Statement



Generative AI tools (Gemini, Claude) were used as a support resource during the project. AI was used to help explain SQL concepts, troubleshoot SQL errors, review queries, and assist with testing and documentation. Team members reviewed and tested the generated suggestions before including them in the project. AI was not treated as a source for the project's collected business data.

