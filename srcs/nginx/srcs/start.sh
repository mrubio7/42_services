#config nginx
adduser -D -g 'www' www && \
chown -R www:www /var/lib/nginx && \
chown -R www:www /www & \
mkdir -p /var/run/nginx
mv www/web www/localhost

#certificate ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/localhost.key -out /etc/ssl/localhost.cert -subj "/C=ES/ST=Spain/L=Madrid/O=42Madrid/OU=42/CN=127.0.0.1"

#coonfig openrc
mkdir -p /run/openrc \
touch /run/openrc/softlevel

/bin/bash
nginx -g "daemon off;"