drop table if exists archived_device_id;
create table archived_device_id (
original_licence_no text, 
device_id text, 
first_licence_dt text, 
end_date text, 
device_identifier text
);
load data local infile 'archived_device_id.csv' into table archived_device_id fields terminated by '	' ignore 1 lines;
