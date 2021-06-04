install_type=""
server_name=""
server_id=""
ftp_dir=""

function get_install_type() {
    echo -ne "\033[32m Tipo de instalacion [ejemplo: storage]: \033[0m"
    read installType
    if [[ -z "$installType" ]]; then
        get_install_type
    else
        install_type=$installType
    fi
}

function get_server_name() {
    echo -ne "\033[32m Nombre del servidor [ejemplo: example.com]: \033[0m"
    read serverName
    if [[ -z "$installType" ]]; then
        get_server_name
    else
        server_name=$serverName
    fi
}

function get_server_id() {
    echo -ne "\033[32m ID del servidor [ejemplo: 1]: \033[0m"
    read serverID
    if [[ -z "$serverID" ]]; then
        get_server_id
    else
        server_id=$serverID
    fi
}

function get_ftp_dir() {
    echo -ne "\033[32m Directorio del FTP: \033[0m"
    read ftpDir
    if [[ -z "$ftpDir" ]]; then
        get_ftp_dir
    else
        ftp_dir=$ftpDir
    fi
}

get_install_type
get_server_name
get_server_id
get_ftp_dir

server_root=/var/www/$server_name
ftp_user=$install_type
ftp_password=$(openssl rand -base64 12)
ftp_port="21"
