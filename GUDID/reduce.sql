drop table if exists GUDID;

create table GUDID (
  deviceDescription varchar(2001),
  versionModelNumber varchar(81),
  catalogNumber varchar(80),
  companyName varchar(112)
);

insert into GUDID
select deviceDescription, versionModelNumber, catalogNumber, companyName
from device;

create index idx_cat on GUDID(catalogNumber);
create index idx_ver on GUDID(versionModelNumber);
