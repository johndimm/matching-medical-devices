drop procedure if exists  matchStats;
delimiter $$

create procedure matchStats()
begin

select count(*) 'number of unique device_identifiers'
from u_dev;

select count(*) 'number of unique catalogNumbers'
from u_cat;

select count(*) 'number of unique versionModelNumbers'
from u_mod;

select count(*) 'number of unque companies'
from company;

#
# How many matches from MDALL to GUDID?
#
select match_cat, match_mod, count(*) 'MDALL matches to GUDID'
from m_dev
group by 1, 2;

#
# How many matches for GUDID to MDALL?
#
select match_cat, match_mod, count(*) 'GUDID matches to MDALL'
from m_catmod
group by 1, 2;

set @total_dev = (select count(*) from m_dev);
set @matched_dev = (select count(*) from m_dev where match_cat or match_mod);

set @total_catmod = (select count(*) from m_catmod);
set @matched_catmod = (select count(*) from m_catmod where match_cat or match_mod);

select 'pc matched MDALL', round(100 * @matched_dev / @total_dev);
select 'pc matched GUDID', round(100 * @matched_catmod / @total_catmod);
end $$

delimiter ;
