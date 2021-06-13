if [[ $install_type == 'storage' ]]; then
    sb_template=./templates/$OS/server_block_storage.conf

elif [[ $install_type == 'encoder' ]]; then
    sb_template=./templates/$OS/server_block_encoder.conf
else
    sb_template=./templates/$OS/server_block.conf
fi

touch /etc/nginx/conf.d/$server_name.conf
cat $sb_template >/etc/nginx/conf.d/$server_name.conf
sed -i "s/{server_name}/$server_name/g" /etc/nginx/conf.d/$server_name.conf
systemctl restart nginx
