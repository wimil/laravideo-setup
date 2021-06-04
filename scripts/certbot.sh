if [[ $OS == 'ubuntu' ]]; then
    apt install certbot python3-certbot-nginx -y
else
    yum install certbot python3-certbot-nginx -y
fi

#certbot certonly --webroot --non-interactive --agree-tos --register-unsafely-without-email -w /usr/share/nginx/html -d $server_name

certbot certonly --nginx -d $server_name  --non-interactive --agree-tos --register-unsafely-without-email