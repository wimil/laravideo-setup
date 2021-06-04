if [[ $install_type == 'encoder' ]]; then

    # Upload File Size
    sed '/http {/a \    client_max_body_size 6500M;' -i /etc/nginx/nginx.conf
    sed -i 's,^upload_max_filesize =.*$,upload_max_filesize = 6000M,' $php_ini_path
    sed -i 's,^post_max_size =.*$,post_max_size = 6500M,' $php_ini_path
    systemctl restart $php_service_name
    systemctl restart nginx

    # Movemos los binarios ffmpeg
    mv $server_root/ffmpeg/$OS/ffmpeg /usr/bin/ffmpeg
    mv $server_root/ffmpeg/$OS/ffprobe /usr/bin/ffprobe
    chmod +x /usr/bin/ffmpeg
    chmod +x /usr/bin/ffprobe

    if [[ $OS == 'centos' ]]; then
        chcon -t execmem_exec_t '/usr/bin/ffmpeg'
        chcon -t execmem_exec_t '/usr/bin/ffprobe'
    fi

    # Configurando el supervisor
    touch /etc/supervisord.d/encoder.ini
    cat ./templates/supervisor/encoder.ini >/etc/supervisord.d/encoder.ini
    sed -i "s/{server_name}/$server_name/g;s/{server_id}/$server_id/g" /etc/supervisord.d/encoder.ini

    touch /etc/supervisord.d/storing.ini
    cat ./templates/supervisor/storing.ini >/etc/supervisord.d/storing.ini
    sed -i "s/{server_name}/$server_name/g;s/{server_id}/$server_id/g" /etc/supervisord.d/storing.ini

    touch /etc/supervisord.d/backup.ini
    cat ./templates/supervisor/backup.ini >/etc/supervisord.d/backup.ini
    sed -i "s/{server_name}/$server_name/g;s/{server_id}/$server_id/g" /etc/supervisord.d/backup.ini

    touch /etc/supervisord.d/download.ini
    cat ./templates/supervisor/download.ini >/etc/supervisord.d/download.ini
    sed -i "s/{server_name}/$server_name/g;s/{server_id}/$server_id/g" /etc/supervisord.d/download.ini

    message "success" "Tipo encoder Configurado!!"

elif [[ $install_type == 'storage' ]]; then
    message "success" "Tipo storage Configurado!!"
fi

#systemctl restart supervisord

