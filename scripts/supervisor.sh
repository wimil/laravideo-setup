if [[ $OS == 'ubuntu' ]]; then
    apt install supervisor -y
else
    yum install supervisor -y
fi

systemctl start supervisord
systemctl enable supervisord
