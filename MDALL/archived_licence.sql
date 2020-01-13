drop table if exists archived_licence;
create table archived_licence (
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
load data local infile 'archived_licence.csv' into table archived_licence fields terminated by '	' ignore 1 lines;
