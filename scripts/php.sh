if [[ $OS == 'ubuntu' ]]; then
    apt install php-fpm php-bcmath php-xml php-mbstring php-zip php-mysql php-pear -y
    systemctl enable php7.4-fpm.service

    #systemctl restart php7.4-fpm.service

    php_ini_path=/etc/php/7.4/fpm/php.ini
    www_conf_path=/etc/php/7.4/fpm/pool.d/www.conf
    php_service_name=php7.4-fpm.service

else
    #centos
    yum install yum-utils -y
    yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
    yum --disablerepo="*" --enablerepo="remi-safe" list php[7-9][0-9].x86_64
    yum-config-manager --enable remi-php74
    yum install php php-fpm php-common php-bcmath php-xml php-mbstring php-json php-zip php-mysqlnd php-pear php-devel -y
    systemctl enable php-fpm

    php_ini_path=/etc/php.ini
    www_conf_path=/etc/php-fpm.d/www.conf
    php_service_name=php-fpm
fi

# Configuramos php-fpm
cat ./templates/$OS/www.conf >$www_conf_path

if [[ $install_type == 'encoder' ]]; then
    sed -i "s/;request_terminate_timeout = 0/request_terminate_timeout = 10m/g" $www_conf_path
else
    echo ""
fi

systemctl restart $php_service_name

message "success" "PHP 7.4 Instalado"
