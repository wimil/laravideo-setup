function add_supervisor_proccess() {
    local name=$1
    touch $supervisor_path/$name.ini
    cat ./templates/supervisor/$name.ini >$supervisor_path/$name.ini
    sed -i "s/{server_name}/$server_name/g;s/{server_id}/$server_id/g" $supervisor_path/$name.ini
}

if [[ $OS == 'ubuntu' ]]; then
    supervisor_path=/etc/supervisor/conf.d
else
    supervisor_path=/etc/supervisord.d
fi

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

    if [[ $OS == 'ubuntu' ]]; then
        # Instalamos paquetes adicionales para ffmpeg
        apt install libass9 libvorbisenc2 fdkaac libmp3lame0 libopus0 libx264-155 libx265-179 libvpx6 -y
    else
        chcon -t execmem_exec_t '/usr/bin/ffmpeg'
        chcon -t execmem_exec_t '/usr/bin/ffprobe'
    fi

    add_supervisor_proccess "encoder"

    add_supervisor_proccess "storing"

    add_supervisor_proccess "backup"

    add_supervisor_proccess "download"

    message "success" "Tipo encoder Configurado!!"

elif [[ $install_type == 'storage' ]]; then

    add_supervisor_proccess "move"

    message "success" "Tipo storage Configurado!!"
fi

supervisorctl reread
supervisorctl update
