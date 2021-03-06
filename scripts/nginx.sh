if [[ $OS == 'ubuntu' ]]; then
    apt install nginx nginx-extras -y
    default_user_nginx='www-data'
else
    yum install nginx -y
    default_user_nginx='nginx'
fi

systemctl enable nginx
systemctl start nginx

sed -i "s/user $default_user_nginx/user www/g" /etc/nginx/nginx.conf

service nginx restart

message "success" "Nginx Instalado"
