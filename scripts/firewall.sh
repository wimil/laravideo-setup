if [[ $OS == 'ubuntu' ]]; then
    ufw allow OpenSSH
    ufw allow 'Nginx Full'
    ufw enable
else
    yum install firewalld -y
    systemctl start firewalld
    systemctl enable firewalld
    firewall-cmd --permanent --zone=public --add-service=http --add-service=https --add-service=ftp
fi
message "success" "Firewall instalado y configurado"