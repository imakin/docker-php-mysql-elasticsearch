#!/bin/bash


# Empty the php.ini file first
> /usr/local/etc/php/php.ini

# Append custom PHP settings to php.ini
echo "max_execution_time=120" >> /usr/local/etc/php/php.ini && \
echo "max_input_time=60" >> /usr/local/etc/php/php.ini && \
echo "max_input_vars=10000" >> /usr/local/etc/php/php.ini && \
echo "memory_limit=5120M" >> /usr/local/etc/php/php.ini
echo "extension=mysqli" >> /usr/local/etc/php/php.ini
echo "extension=pdo_mysql.so" >> /usr/local/etc/php/php.ini
echo "extension=zip.so" >> /usr/local/etc/php/php.ini
echo "extension=intl.so" >> /usr/local/etc/php/php.ini
echo "extension=sodium.so" >> /usr/local/etc/php/php.ini
echo "extension=bcmath.so" >> /usr/local/etc/php/php.ini
echo "extension=gd.so" >> /usr/local/etc/php/php.ini

# Enable the SSL site configuration
a2ensite default-ssl

a2enmod ssl
a2enmod rewrite

# Test Apache configuration
apache2ctl configtest

#setting to this, so magento can use the id_field_data
curl -X PUT "http://elasticsearchdocker:9200/_cluster/settings" \
-H "Content-Type: application/json" \
-d '{
  "persistent": {
    "indices.id_field_data.enabled": true
  }
}'