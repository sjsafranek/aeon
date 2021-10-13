#!/bin/bash

psql -c "CREATE USER geodev WITH PASSWORD 'dev'"
psql -c "CREATE DATABASE geodev"
psql -c "GRANT ALL PRIVILEGES ON DATABASE geodev to geodev"
psql -c "ALTER USER geodev WITH SUPERUSER"

# PGPASSWORD=dev psql -d finddb -U finduser -f database.sql

cd base_schema
PGPASSWORD=dev psql -d geodev -U geodev -f db_setup.sql
cd ..
