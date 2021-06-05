mv ./templates/letsencrypt-renew /etc/cron.daily/letsencrypt-renew
chmod +x /etc/cron.daily/letsencrypt-renew
crontab -l | {
    cat
    echo "01 02,14 * * * /etc/cron.daily/letsencrypt-renew"
} | crontab -

message "success" "Certbot Instalado y configurado"