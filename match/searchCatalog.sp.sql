drop procedure if exists searchCatalog;

delimiter $$
create procedure searchCatalog(_catalogNumber text)
begin

  select 'MDALL' as source, MDALL.*
  from MDALL
  where device_identifier = _catalogNumber 
  limit 20
  ;

  select 'GUDID' as source, GUDID.*
  from GUDID
  where catalogNumber = _catalogNumber
  limit 20
  ;

end $$

delimiter ;
