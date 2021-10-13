/*======================================================================*/
--  db_setup.sql
--   -- :mode=pl-sql:tabSize=3:indentSize=3:
--  Mon Aug 17 14:44:44 PST 2015 @144 /Internet Time/
--  Purpose:
--  NOTE: must be connected as 'postgres' user or a superuser to start.
/*======================================================================*/

\set ON_ERROR_STOP on
set client_min_messages to 'warning';

-- add extentions
\i create_extensions.sql

-- add function handlers
\i create_general_functions.sql

-- create tables
\i create_config_table.sql


\i create_datasources_table.sql
