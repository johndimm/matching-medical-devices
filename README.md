### Matching GUDID and MDALL

This exercise is about matching data from two sources using multiple identifiers.

#### Findings

* 30% of the distinct MDALL records match exactly to records in GUDID
* 25% of the distinct GUDID records match exactly to records in MDALL

#### Strategy

* Load the relevant fields into narrow indexed tables in mysql.
* Extract the distinct id's, to avoid cartesian products from dups.
* Find exact matches between sets of distinct id's.
* Set them aside so we can concentrate on the records in both sources that fail to 
match exactly.

#### Install and run the scripts

* Create an empty mysql database.
* On the command line, run the run.sh script in the root directory.


#### Method

* Download data from the source websites using curl.
* Convert json to csv using a python script.
* Construct wide generic (all text) tables and bulk load the files.
* Run SQL queries to find the width of the fields we want to extract.
* Create narrow tables (varchar) for the interesting fields.
* Extract data from the wide tables to the narrow tables.
* Check each identifier for duplicate records.
* Extract distinct identifiers
  * device_identifier
  * catalogNumber
  * versionModelNumber
* Find exact matches 
  * device_identifier to catalogNumber
  * device_identifier to versionModelNumber
* Count matches and non-matches

#### The "narrow" tables

```
mysql> describe GUDID;
+--------------------+---------------+------+-----+---------+-------+
| Field              | Type          | Null | Key | Default | Extra |
+--------------------+---------------+------+-----+---------+-------+
| deviceDescription  | varchar(2001) | YES  |     | NULL    |       |
| versionModelNumber | varchar(81)   | YES  | MUL | NULL    |       |
| catalogNumber      | varchar(80)   | YES  | MUL | NULL    |       |
| companyName        | varchar(112)  | YES  |     | NULL    |       |
+--------------------+---------------+------+-----+---------+-------+
4 rows in set (0.24 sec)

mysql> describe MDALL;
+---------------------+--------------+------+-----+---------+-------+
| Field               | Type         | Null | Key | Default | Extra |
+---------------------+--------------+------+-----+---------+-------+
| active              | tinyint(1)   | YES  |     | NULL    |       |
| device_identifier   | varchar(50)  | YES  | MUL | NULL    |       |
| original_licence_no | varchar(6)   | YES  |     | NULL    |       |
| licence_name        | varchar(150) | YES  |     | NULL    |       |
| company_id          | varchar(6)   | YES  |     | NULL    |       |
| company_name        | varchar(89)  | YES  |     | NULL    |       |
+---------------------+--------------+------+-----+---------+-------+
```

#### Dups

This shows that there are lots of dups for MDALL based on device_identifier.  The second row
says that there are 120,995 identifiers that appear twice.  The last row says there is one that appears
in 108 records.

```
+-----+---------------------------+
| cnt | dups of device_identifier |
+-----+---------------------------+
|   1 |                   1446626 |
|   2 |                    120995 |
|   3 |                     24437 |
|   4 |                      7394 |
|   5 |                      3079 |
|   6 |                      2458 |
|   7 |                      1302 |
|   8 |                       771 |
|   9 |                       453 |
|  10 |                       377 |
|  11 |                       253 |
|  12 |                       196 |
|  13 |                       124 |
|  14 |                       153 |
|  15 |                        81 |
|  16 |                        99 |
|  17 |                        34 |
|  18 |                        50 |
|  19 |                        28 |
|  20 |                        25 |
|  21 |                        25 |
|  22 |                        16 |
|  23 |                         9 |
|  24 |                        12 |
|  25 |                         8 |
|  26 |                        13 |
|  27 |                        11 |
|  28 |                        12 |
|  29 |                        12 |
|  30 |                        11 |
|  31 |                         6 |
|  32 |                         7 |
|  33 |                         2 |
|  34 |                         3 |
|  35 |                         5 |
|  36 |                         4 |
|  37 |                         5 |
|  38 |                         5 |
|  40 |                         2 |
|  41 |                         3 |
|  42 |                         1 |
|  43 |                         2 |
|  45 |                         1 |
|  46 |                         2 |
|  47 |                         3 |
|  48 |                         1 |
|  51 |                         1 |
|  54 |                         1 |
|  58 |                         1 |
|  59 |                         1 |
|  60 |                         1 |
|  67 |                         1 |
|  71 |                         1 |
|  75 |                         1 |
|  81 |                         2 |
|  83 |                         1 |
|  84 |                         1 |
|  85 |                         3 |
|  86 |                         2 |
|  96 |                         1 |
| 108 |                         1 |
+-----+---------------------------+

```

The other identifiers are even less unique.  See MDALL/dups.out.

To dig in a bit more, here are six devices with the same identifier.  The same product is available
from multiple companies.  Sometimes there are subtle differences, like "Victory Type"
vs "Energy Type".  My claim is that it's good to match on distinct id's, and disambiguate these on 
another phase of the project.

```
mysql> select *
    -> from MDALL
    -> where device_identifier = '0.16X13'
    -> \G
*************************** 1. row ***************************
             active: 1
  device_identifier: 0.16X13
original_licence_no: 91797
       licence_name: VIGOR STERILE, DISPOSABLE ACUPUNCTURE NEEDLES
         company_id: 121577
       company_name: THE VITALITY DEPOT
*************************** 2. row ***************************
             active: 1
  device_identifier: 0.16X13
original_licence_no: 96600
       licence_name: VICTORY STERILE DISPOSABLE ACUPUNCTURE NEEDLES
         company_id: 134293
       company_name: WUXI JIAJIAN MEDICAL INSTRUMENT CO., LTD.
*************************** 3. row ***************************
             active: 1
  device_identifier: 0.16X13
original_licence_no: 96601
       licence_name: ENERGY STERILE DISPOSABLE ACUPUNCTURE NEEDLES
         company_id: 134293
       company_name: WUXI JIAJIAN MEDICAL INSTRUMENT CO., LTD.
*************************** 4. row ***************************
             active: 0
  device_identifier: 0.16X13
original_licence_no: 88837
       licence_name: DISPOSABLE ACUPUNCTURE NEEDLE
         company_id: 125839
       company_name: TIANJIN EMPECS MEDICAL DEVICE CO., LTD.
*************************** 5. row ***************************
             active: 0
  device_identifier: 0.16X13
original_licence_no: 89237
       licence_name: ACUPUNCTURE NEEDLES (VICTORY TYPE)
         company_id: 134293
       company_name: WUXI JIAJIAN MEDICAL INSTRUMENT CO., LTD.
*************************** 6. row ***************************
             active: 0
  device_identifier: 0.16X13
original_licence_no: 89238
       licence_name: ACUPUNCTURE NEEDLES (ENERGY TYPE)
         company_id: 134293
       company_name: WUXI JIAJIAN MEDICAL INSTRUMENT CO., LTD.
6 rows in set (0.07 sec)

```

#### Output

The stored procedure searchCatalog checks both sources for a given id.  Output is
limited to maximum of 20 records from each, since it is easy to find id's that match
thousands of records.

```
$ mysql -e "call searchCatalog('1013470-180')"
+--------+--------+-------------------+---------------------+------------------------+------------+-----------------+
| source | active | device_identifier | original_licence_no | licence_name           | company_id | company_name    |
+--------+--------+-------------------+---------------------+------------------------+------------+-----------------+
| MDALL  |      1 | 1013470-180       | 96161               | ARMADA 18 PTA CATHETER | 100230     | ABBOTT VASCULAR |
+--------+--------+-------------------+---------------------+------------------------+------------+-----------------+
+--------+-----------------------------------------------------------------+--------------------+---------------+----------------------+
| source | deviceDescription                                               | versionModelNumber | catalogNumber | companyName          |
+--------+-----------------------------------------------------------------+--------------------+---------------+----------------------+
| GUDID  | Armada 18 PTA Catheter 6.0 mm x 180 mm x 150 cm / Over-The-Wire | 1013470-180        | 1013470-180   | ABBOTT VASCULAR INC. |
+--------+-----------------------------------------------------------------+--------------------+---------------+----------------------+

```

The stored procedure matchStats returns a number of relevant counts:

```
$ mysql -e "call matchStats()"
+-------------------------------------+
| number of unique device_identifiers |
+-------------------------------------+
|                             1609135 |
+-------------------------------------+
+---------------------------------+
| number of unique catalogNumbers |
+---------------------------------+
|                         1294429 |
+---------------------------------+
+--------------------------------------+
| number of unique versionModelNumbers |
+--------------------------------------+
|                              2160426 |
+--------------------------------------+
+---------------------------+
| number of unque companies |
+---------------------------+
|                      6439 |
+---------------------------+
+-----------+-----------+------------------------+
| match_cat | match_mod | MDALL matches to GUDID |
+-----------+-----------+------------------------+
|         0 |         0 |                1120794 |
|         0 |         1 |                 186582 |
|         1 |         0 |                  50290 |
|         1 |         1 |                 251469 |
+-----------+-----------+------------------------+
+-----------+-----------+------------------------+
| match_cat | match_mod | GUDID matches to MDALL |
+-----------+-----------+------------------------+
|         0 |         0 |                1724870 |
|         1 |         1 |                 261081 |
|         1 |         0 |                  74254 |
|         0 |         1 |                 238843 |
+-----------+-----------+------------------------+
+------------------+----------------------------------------+
| pc matched MDALL | round(100 * @matched_dev / @total_dev) |
+------------------+----------------------------------------+
| pc matched MDALL |                                     30 |
+------------------+----------------------------------------+
+------------------+----------------------------------------------+
| pc matched GUDID | round(100 * @matched_catmod / @total_catmod) |
+------------------+----------------------------------------------+
| pc matched GUDID |                                           25 |
+------------------+----------------------------------------------+
```

#### Next Steps

Now that the exact matches are sequestered, we can try to match the others 
using SQL queries.  The tables are indexed to speed up experiments.  One 
idea is to check to see if one id is a substring of 
another.  Here is one example (the f_dev is the remainder table for MDALL and 
f_catmod has the unmatched id's from GUDID):

```
select device_identifier, versionModelNumber
from (select * from f_dev limit 60 offset 60) as f_dev
join f_catmod on length(device_identifier) > 3 
  and versionModelNumber != '' 
  and locate(device_identifier, versionModelNumber) = 1 
;

+-------------------+--------------------+
| device_identifier | versionModelNumber |
+-------------------+--------------------+
| #3035             | #3035-KA           |
| #3030             | #3030-KA           |
| #3025             | #3025-KA           |
| #3020             | #3020-KA           |
| #3015             | #3015-KA           |
| #2635             | #2635-KA           |
| #2620             | #2620-KA           |
| #2615             | #2615-KA           |
| #2612             | #2612-KA           |
| #2610             | #2610-KA           |
+-------------------+--------------------+
```

This suggests that GUDID id's sometimes append "-KA".  Maybe there are other 
appended strings.

Other methods:

* pull the non-matching data from both sources for a particular company and 
scan manually for patterns.
* create an alphanumeric histogram of id's and check for matches, to find id's that contain mostly
the same letters and numbers but may be shifted.
* run full-text searches of descriptions in batch, given a description as query.
* as already suggested, pull the top words by tf/idf and compare.