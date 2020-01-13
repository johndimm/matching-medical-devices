drop table if exists company;
create table company (
company_id text, 
company_name text, 
addr_line_1 text, 
addr_line_2 text, 
addr_line_3 text, 
postal_code text, 
city text, 
country_cd text, 
region_cd text, 
company_status text
);
load data local infile 'company.csv' into table company fields terminated by '	' ignore 1 lines;
