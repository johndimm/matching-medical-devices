select 
  max(length(device_identifier)),
  max(length(original_licence_no))
from active_device_id;

select 
  max(length(device_identifier)),
  max(length(original_licence_no))
from archived_device_id;

select
  max(length(licence_name)),
  max(length(original_licence_no)),
  max(length(company_id))
from active_licence;

select
  max(length(licence_name)),
  max(length(original_licence_no)),
  max(length(company_id))
from archived_licence;


select
  max(length(company_name)),
  max(length(company_id))
from company;

