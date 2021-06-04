#!/bin/bash
source ./scripts/init.sh

# ------------- Descargar archivos --------#
source ./scripts/download.sh

# ------------- Instalar nginx --------#
source ./scripts/nginx.sh

# ------------- Instalar php --------#
source ./scripts/php.sh

# ------------- Configuracion del sitio --------#

# Creamos el folder para el server block
mkdir -p $server_root/public

# Instalar certbot & lo configuramos
source ./scripts/certbot.sh

# Configuramos nginx el server block
source ./scripts/serverblock_config.sh

# Creamos un cron para renovar el ceritficado
source ./scripts/cron.sh

# ------------- PureFTP --------#
source ./scripts/ftp.sh

# ------------- Supervisor --------#
source ./scripts/supervisor.sh

# ------------- Firewall --------#
source ./scripts/firewall.sh

# ------------- Composer --------#
source ./scripts/composer.sh

# ------------- Configuracion del sitio --------#
source ./scripts/website_config.sh

# ------------- Configuracion tipo de instalacion --------#
source ./scripts/install_type_config.sh
