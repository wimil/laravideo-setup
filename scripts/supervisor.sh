if [[ $OS == 'ubuntu' ]]; then
    apt install supervisor -y
    supervisor_service_name=supervisor
    cat ./templates/ubuntu/supervisor.conf >/etc/supervisor/supervisord.conf
else
    yum install supervisor -y
    supervisor_service_name=supervisord
fi

systemctl restart $supervisor_service_name
systemctl enable $supervisor_service_name
