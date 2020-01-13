#
# Get the unique catalogNumbers.
#
drop table if exists u_cat;
create table u_cat as
select catalogNumber, count(*) as cnt
from GUDID
group by 1;
create index idx_cat on u_cat(catalogNumber);

select "created u_cat";

#
# Get the unique versionModelNumbers.
#
drop table if exists u_mod;
create table u_mod as
select versionModelNumber, count(*) as cnt
from GUDID
group by 1;
create index idx_mod on u_mod(versionModelNumber);

select "created distinct mod";

#
# Get the unique device_identifiers.
#
drop table if exists u_dev;
create table u_dev as
select device_identifier, count(*) as cnt
from MDALL
group by 1;
create index idx_dev on u_dev(device_identifier);

select "created u_dev";

#
# Get the unique pairs of cat and mod.  We hope to match 
# device_identifiers to one or the other, or both.
#
drop table if exists u_catmod;
create table u_catmod as
select catalogNumber, versionModelNumber, count(*) as cnt
from GUDID
group by 1,2;
create index idx_cat on u_catmod(catalogNumber);
create index idx_mod on u_catmod(versionModelNumber);

