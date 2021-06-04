if [[ $OS == 'ubuntu' ]]; then
    apt install pure-ftpd -y
else
    yum install pure-ftpd -y
fi

cat ./templates/ftp.conf >/etc/pure-ftpd/pure-ftpd.conf
mkdir -p /etc/ssl/private/
openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem -subj "/C=US/ST=Denial/L=Springfield/O=Rldev/OU=IT Department/CN=$server_name"
chmod 600 /etc/ssl/private/pure-ftpd.pem
systemctl enable pure-ftpd
systemctl start pure-ftpd
(
    echo $ftp_password
    echo $ftp_password
) | pure-pw useradd $ftp_user -u www -g www -d $ftp_dir
chown -R www:www $server_root
pure-pw mkdb
systemctl restart pure-ftpd

message "success" "PureFtp Instalado y configurado"
