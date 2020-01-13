drop table if exists actdev;
create table actdev 
(
  device_identifier varchar(50),
  original_licence_no varchar(6),
  index(device_identifier),
  index(original_licence_no)
);

insert into actdev
select device_identifier, original_licence_no
from active_device_id;

drop table if exists archdev;
create table archdev 
(
  device_identifier varchar(50),
  original_licence_no varchar(6),
  index(device_identifier),
  index(original_licence_no)
);

insert into archdev
select device_identifier, original_licence_no
from archived_device_id;


drop table if exists actlic;
create table actlic
(
  original_licence_no varchar(6),
  licence_name varchar(150),
  company_id varchar(6),
  index(original_licence_no),
  index(company_id)
);



insert into actlic
select original_licence_no, licence_name, company_id from active_licence;

drop table if exists archlic;
create table archlic
(
  original_licence_no varchar(6),
  licence_name varchar(150),
  company_id varchar(6),
  index(original_licence_no),
  index(company_id)
);

insert into archlic
select original_licence_no, licence_name, company_id from archived_licence;

drop table if exists comp;
create table comp
(
  company_id varchar(6),
  company_name varchar(89),
  index(company_name)
);

insert into comp
select company_id, company_name from company;  

drop table if exists MDALL;
create table MDALL 
(
  active boolean,
  device_identifier varchar(50),
  original_licence_no varchar(6),
  licence_name varchar(150),
  company_id varchar(6),
  company_name varchar(89),
  index (device_identifier)
);

insert into MDALL 
select
  true as active,
  device_identifier,
  dev.original_licence_no,
  licence_name,
  lic.company_id,
  company_name
from
  actdev as dev
join
  actlic as lic on lic.original_licence_no = dev.original_licence_no
join
  comp on comp.company_id = lic.company_id
;

insert into MDALL 
select
  false as active,
  device_identifier,
  dev.original_licence_no,
  licence_name,
  lic.company_id,
  company_name
from
  archdev as dev
join
  archlic as lic on lic.original_licence_no = dev.original_licence_no
join
  comp on comp.company_id = lic.company_id
;
