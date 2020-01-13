# Download the source data in json format.
./download.sh

# Extract SQL create table and csv file from json.
./prepare.sh

# Load into the database.
./load.sh

# Find the lengths of the fields we want.
mysql < maxlen.sql > maxlen.out

# Extract only the fields we want, into varchars.
mysql < reduce.sql 
