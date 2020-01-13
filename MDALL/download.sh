rm *.json

# Active Device Identifier
curl -o active_device_id.json https://health-products.canada.ca/api/medical-devices/deviceidentifier/?state=active&type=json

# Archived Device Identifier
curl -o archived_device_id.json https://health-products.canada.ca/api/medical-devices/deviceidentifier/?state=archived&type=json

# Active License
curl -o active_licence.json https://health-products.canada.ca/api/medical-devices/licence/?state=active&type=json&lang=en

# Archived License
curl -o archived_licence.json https://health-products.canada.ca/api/medical-devices/licence/?state=archived&type=json&lang=en

# Company
curl -o company.json https://health-products.canada.ca/api/medical-devices/company/?type=json
