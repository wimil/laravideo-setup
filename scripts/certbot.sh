if [[ $OS == 'ubuntu' ]]; then
    apt install certbot python3-certbot-nginx -y
    certbot certonly --nginx -d $server_name  --non-interactive --agree-tos --register-unsafely-without-email
else
    yum install certbot python3-certbot-nginx -y
    certbot certonly --webroot --non-interactive --agree-tos --register-unsafely-without-email -w /usr/share/nginx/html -d $server_name
fi