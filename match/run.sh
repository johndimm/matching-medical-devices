#
# Do we have unique identifiers?  No, far from it.
#
mysql < dups.sql > dups.out

#
# Extract unique ids for matching.
#
mysql < unique.sql

#
# Find exact matches.
#
mysql < match.sql

#
# Create stored procedures.
#
mysql < matchStats.sp.sql
mysql < searchCatalog.sp.sql

#
# How many did we find?
#
mysql -e "call matchStats()"

#
# Example of stored procedure for search.
#
mysql -e "call searchCatalog('1013470-180')"



