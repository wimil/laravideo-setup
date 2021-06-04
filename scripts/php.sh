if [[ $OS == 'ubuntu' ]]; then
    apt install php-fpm php-bcmath php-xml php-mbstring php-zip php-mysql php-pear -y
    systemctl enable php7.4-fpm.service

    # Configuramos php-fpm
    cat ./templates/ubuntu/www.conf >/etc/php/7.4/fpm/pool.d/www.conf
    systemctl restart php7.4-fpm.service

    php_ini_path=/etc/php/7.4/fpm/php.ini
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
    php_service_name=php-fpm
fi

message "success" "PHP 7.4 Instalado"
