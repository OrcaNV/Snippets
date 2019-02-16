#!/bin/bash

# Which program is using the SSL cert
# sudo netstat -plnt
# sudo lsof -i :443


#NOTE: certbot is the new name for letsencrypt

# check current certificates
# sudo letsencrypt certificates

# add
#sudo letsencrypt --webroot -w /var/www/html certonly --cert-name test.preskofan.com -d test.preskofan.com,jam.preskofan.com

#renew
sudo letsencrypt-auto renew --webroot -w /var/www/html

