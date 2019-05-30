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



##############################################
#NOTE: if using nginx
#
# sudo vi /var/opt/gitlab/nginx/conf/gitlab-http.conf
#    #ssl_certificate /etc/gitlab/ssl/git.preskofan.com.crt;
#    #ssl_certificate_key /etc/gitlab/ssl/git.preskofan.com.key;
#    ssl_certificate      /etc/letsencrypt/live/git.preskofan.com/fullchain.pem;
#    ssl_certificate_key  /etc/letsencrypt/live/git.preskofan.com/privkey.pem;
