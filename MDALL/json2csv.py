import json
import sys

#
# From a json file containing an array of objects, jsonFile.json, generate
#
#  - jsonFile.sql -- a SQL table definition (everything is text)
#  - jsonFile.csv -- a .tsv file ready to bulk insert into a database
#

def main():
  if len(sys.argv) < 2:
     print ("usage: json2csv.py jsonFile.json\n")
     return

  fname = sys.argv[1]

  # Use the base filename as table name.
  tableName = fname.replace(".json", '')

  # Read the whole input file.
  file = open (fname, 'r')
  data = file.read()
  file.close()

  # Convert to json object.
  jsonData = json.loads(data)

  # Assume all objects in the array have the same structure.
  fields = [field for field in jsonData[0]]

  # Generate SQL create table statment.
  createTable(tableName, fields)

  # Generate tsv file.
  data2csv(tableName, fields, jsonData)

def createTable(tableName, fields):
  file = open(tableName + ".sql", "w")
  body = " text, \n".join(fields) + " text"
  file.write ("drop table if exists %s;\n" % tableName)
  file.write ("create table %s (\n%s\n);\n" % (tableName, body)) 
  file.write("load data local infile '%s.csv' into table %s fields terminated by '\t' ignore 1 lines;\n" % (tableName, tableName))
  file.close()

def data2csv(tableName, fields, jsonData):
  file = open (tableName + ".csv", "w")
  file.write("\t".join(fields) + "\n")
  for item in jsonData:
    vals = []
    for field in fields:
       vals.append(str(item[field]))
    file.write ("\t".join(vals) + "\n")
  file.close()

main()

