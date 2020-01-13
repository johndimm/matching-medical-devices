drop table if exists active_licence;
create table active_licence (
original_licence_no text, 
licence_status text, 
appl_risk_class text, 
licence_name text, 
first_licence_status_dt text, 
last_refresh_dt text, 
end_date text, 
licence_type_cd text, 
company_id text, 
licence_type_desc text
);
load data local infile 'active_licence.csv' into table active_licence fields terminated by '	' ignore 1 lines;
