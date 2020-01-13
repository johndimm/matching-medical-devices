drop table if exists active_device_id;
create table active_device_id (
original_licence_no text, 
device_id text, 
first_licence_dt text, 
end_date text, 
device_identifier text
);
load data local infile 'active_device_id.csv' into table active_device_id fields terminated by '	' ignore 1 lines;
