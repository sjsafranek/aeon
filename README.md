# aeon

Time series framework built on Timescale.


## PostGres InstallPostgres 13

```bash

# Install Postgres 13
sudo aptitude update
sudo aptitude install postgresql-13
sudo aptitude install postgresql-client-13
sudo pg_ctlcluster 13 main start

# Install PostGIS
sudo aptitude install postgresql-13-postgis-3

# Install Timescale
sudo sh -c "echo 'deb [signed-by=/usr/share/keyrings/timescale.keyring] https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -c -s) main' > /etc/apt/sources.list.d/timescaledb.list"
wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/timescale.keyring
sudo apt update
sudo apt install timescaledb-2-postgresql-13


# Configure database
sudo apt install timescaledb-tools
sudo timescaledb-tune

# Restart database
sudo service postgresql restart

# Create new user and database
# sudo su - postgres
# postgres@debian:~$ createuser geodev
# postgres@debian:~$ createdb geodev -O geodev
# psql -c "ALTER USER geodev WITH PASSWORD 'dev';"

# Setup database
cd database
cd ./db_init.sh
'

```
