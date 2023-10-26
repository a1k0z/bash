#!/bin/bash

# Установка часового пояса
timedatectl set-timezone "Europe/Samara"

# Обновление
apt update && apt -y upgrade

# Установка необходимых утилит
apt -y install neovim git net-tools htop wget curl unzip

# Устанавливаем Proxmox агент
apt -y install qemu-guest-agent
systemctl start qemu-guest-agent
systemctl enable qemu-guest-agent

# Отключаем IPv6
echo "net.ipv4.ip_forward=1
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
net.ipv6.conf.lo.disable_ipv6=1" >> /etc/sysctl.conf
sysctl -p

echo "#!/bin/bash
# /etc/rc.local

/etc/sysctl.d
/etc/init.d/procps restart

exit 0" >> /etc/rc.local
chmod 755 /etc/rc.local
