
/*
select device_identifier, catalogNumber
from (select * from f_dev limit 60 offset 80) as f_dev
join f_catmod on length(device_identifier) > 3
  and catalogNumber != '' 
  and locate(device_identifier, catalogNumber) = 1
;
*/

/*
select device_identifier, catalogNumber
from (select * from f_catmod limit 120 offset 80) as f_catmod
join f_dev on length(device_identifier) > 5
  and length(catalogNumber) > 5 
  and locate(catalogNumber, device_identifier) = 1
;
*/


#
# Can we match up some identifiers by checking to see if one id is contained in another?
# Yes, at least one case was found in the first group tested.
#
select device_identifier, versionModelNumber
from (select * from f_dev limit 60 offset 60) as f_dev
join f_catmod on length(device_identifier) > 3 
  and versionModelNumber != '' 
  and locate(device_identifier, versionModelNumber) = 1 
;

/*
device_identifier	versionModelNumber
#3035	#3035-KA
#3030	#3030-KA
#3025	#3025-KA
#3020	#3020-KA
#3015	#3015-KA
#2635	#2635-KA
#2620	#2620-KA
#2615	#2615-KA
#2612	#2612-KA
#2610	#2610-KA
*/

/*
select device_identifier, versionModelNumber
from (select * from f_dev limit 60 offset 60) as f_dev
join f_catmod on length(device_identifier) > 3 
  and length(catalogNumber) > 5 
  and locate(device_identifier, catalogNumber) != 0
;
*/