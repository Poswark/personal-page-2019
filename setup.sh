#!/bin/bash


echo "========= Configurando httpd =========="

echo "instalando httpd"
yum install -y httpd >> /tmp/instalacion.txt
echo "Iniciando el servicio"
systemctl enable --now  httpd >> /tmp/instalacion.txt
echo "Sincronizando la data"
rsync -aP /vagrant/mipagina2019/* /var/www/html/ >> /tmp/instalacion.txt
systemctl restart httpd >> /tmp/instalacion.txt

echo "Terminado"

