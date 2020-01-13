#
# Allow bulk loads from local file.
#
mysql < set_local_infile.sql

# 
# Download data and load it into the database.
#
cd GUDID
./run.sh
cd ..

cd MDALL
./run.sh
cd ..

# 
# Find exact matches using various identifiers.
#
cd match
./run.sh
cd ..
