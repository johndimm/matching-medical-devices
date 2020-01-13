# Download the data from Access GUDID.
./download.sh
unzip GUDID.zip

# Load the device file into the database.
#   Use the top line of device.txt to create the table schema.
#   Every field is just text, to make the load easy. 
mysql < device.sql

# Get the width of the columns we care about.
mysql < maxlen.sql

# Create a reduced table with just the fields we want, as varchar.
mysql < reduce.sql
