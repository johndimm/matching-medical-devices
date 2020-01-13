select 
  max(length(catalogNumber)),
  max(length(versionModelNumber)),
  max(length(companyName)),
  max(length(deviceDescription))
from device;
