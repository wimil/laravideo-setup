mkdir -p /etc/ssl/private/
openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem -subj "/C=US/ST=Denial/L=Springfield/O=Rldev/OU=IT Department/CN=$server_name"
chmod 600 /etc/ssl/private/pure-ftpd.pem

function create_virtual_user_ftp() {
    (
        echo $ftp_password
        echo $ftp_password
    ) | pure-pw useradd $ftp_user -u www -g www -d $ftp_dir
    chown -R www:www $server_root
    pure-pw mkdb

    cat ./templates/$OS/ftp.conf >/etc/pure-ftpd/pure-ftpd.conf
}

if [[ $OS == 'ubuntu' ]]; then
    apt install pure-ftpd -y
    create_virtual_user_ftp

    #cat ./templates/ubuntu/ftp.conf >/etc/pure-ftpd/pure-ftpd.conf

    ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/PureDB
    echo -n "no" >/etc/pure-ftpd/conf/PAMAuthentication
    echo -n "14" >/etc/pure-ftpd/conf/MinUID

    ufw allow 20/tcp
    ufw allow 21/tcp
    ufw allow from any to any proto tcp port 39000:40000
else
    yum install pure-ftpd -y
    create_virtual_user_ftp
    #cat ./templates/centos/ftp.conf >/etc/pure-ftpd/pure-ftpd.conf
fi

#systemctl enable pure-ftpd
#systemctl start pure-ftpd

systemctl enable pure-ftpd
systemctl restart pure-ftpd

message "success" "PureFtp Instalado y configurado"
