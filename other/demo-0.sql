use myrrh;

-- remove all myrrh data except privs
source reset.sql;
-- create roles shown in demo/readme, each with its own user and db
source demo-1.sql;
-- differentiate and interconnect the roles
source demo-2.sql;
-- rename roles, users for better readability
source demo-3.sql;
-- observe the results
source demo-4.sql;

