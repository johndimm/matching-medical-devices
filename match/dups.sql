select cnt, count(*) as 'dups of device_identifier'
from (
  select device_identifier, count(*) as cnt
  from MDALL 
  group by 1
) as t
group by 1
order by 1;

select cnt, count(*) 'dups of original_license_no'
from (
  select original_licence_no, count(*) as cnt
  from MDALL
  group by 1
) as t
group by 1
order by 1;

select cnt, count(*) as 'dups of catalogNumber'
from (
  select catalogNumber, count(*) as cnt
  from GUDID 
  group by 1
) as t
group by 1
order by 1;

select cnt, count(*) as 'dups over versionModelNumber'
from (
  select versionModelNumber, count(*) as cnt
  from GUDID 
  group by 1
) as t
group by 1
order by 1;

select cnt, count(*) as 'dups of company'
from (
  select company_id, count(*) as cnt
  from company
  group by 1
) as t
group by 1
order by 1;

#
# A few examples.
#
  select versionModelNumber, count(*) as cnt
  from GUDID 
  group by 1
  having count(*) between 95 and 105;
  
  select catalogNumber, count(*) as cnt
  from GUDID 
  group by 1
  having count(*) between 95 and 105;

  select device_identifier, count(*) as cnt
  from MDALL
  group by 1
  having count(*) between 29 and 31;
