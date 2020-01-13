#
# Match device to catalogNumber.
#
drop table if exists m_devcat;
create table m_devcat as
select device_identifier 
from u_dev
join u_cat on u_cat.catalogNumber = u_dev.device_identifier
;
create index idx_devcat on m_devcat(device_identifier);

#
# Match device to versionModelNumber.
#
drop table if exists m_devmod;
create table m_devmod as
select device_identifier
from u_dev
join u_mod on u_mod.versionModelNumber = u_dev.device_identifier
;
create index idx_devmod on m_devmod(device_identifier);


#
# Gather both kinds of matches into a single table.
#
drop table if exists m_dev;
create table m_dev as
select device_identifier, 
  m_devcat.device_identifier is not null as match_cat,
  m_devmod.device_identifier is not null as match_mod
from u_dev
left join m_devcat using (device_identifier)
left join m_devmod using (device_identifier)
;

#
# Looking at it from the other side, list the cat and mod and whether either one matches.
#
drop table if exists m_catmod;
create table m_catmod as
select catalogNumber, versionModelNumber, 
  m_devcat.device_identifier is not null as match_cat,
  m_devmod.device_identifier is not null as match_mod
from u_catmod
left join m_devcat on m_devcat.device_identifier = u_catmod.catalogNumber
left join m_devmod on m_devmod.device_identifier = u_catmod.versionModelNumber
;

#
# Create a table with the rest, the devices that do not match.
#
drop table if exists f_dev;
create table f_dev as
select device_identifier
from m_dev
where match_cat = 0 and match_mod = 0;

#
# Create a table with the cat/mods that do not match.
#
drop table if exists f_catmod;
create table f_catmod as
select catalogNumber, versionModelNumber
from m_catmod
where match_cat = 0 and match_mod = 0;