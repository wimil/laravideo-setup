rm -rf $server_root
mkdir -p $server_root
shopt -s dotglob
mv laravideo-$install_type/* $server_root/
cd $server_root
echo "$ftp_user||$ftp_password||$ftp_port" >storage/app/ftp_account.txt
mv .env.example .env
composer install
php artisan key:generate
php artisan storage:link

cd ~/laravideo-install

chown -R www:www $server_root

if [[ $OS == "centos" ]]; then
    chcon -Rt httpd_sys_content_t $server_root
    semanage fcontext -a -t httpd_sys_rw_content_t "$server_root/storage(/.*)?"
    semanage fcontext -a -t httpd_sys_rw_content_t "$server_root/bootstrap/cache(/.*)?"
    restorecon -Rv $server_root
    setsebool -P httpd_can_network_connect_db 1
fi

message "success" "Sitio configurado!"
