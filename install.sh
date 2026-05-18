#!/bin/bash
set -e

#配置文件路径
CONFDIR="/etc/smartdns.d"
#SmartDNS组名
GROUP="china"
#dnsmasq-china-list下载链接
DOWNLOAD_URL="https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master"

WORKDIR="$(mktemp -d)"
cd "$WORKDIR"|| exit 1

echo "Checking whether the configuration folder exists..."
[ -d "$CONFDIR" ] || mkdir -p "$CONFDIR"

CONF_WITH_SERVERS=(accelerated-domains.china apple.china google.china)
CONF_SIMPLE=(bogus-nxdomain.china)

echo "Downloading latest configurations..."
for _conf in "${CONF_WITH_SERVERS[@]}" "${CONF_SIMPLE[@]}"; do
  wget "$DOWNLOAD_URL/$_conf.conf"
done
wget "$DOWNLOAD_URL/Makefile"

echo "Installing new configurations..."
make smartdns SERVER="$GROUP"
for _conf in "${CONF_WITH_SERVERS[@]}" "${CONF_SIMPLE[@]}"; do
  cp "$_conf.smartdns.conf" "$CONFDIR/$_conf.smartdns.conf"
done

echo "Restarting smartdns service..."
if command -v systemctl >/dev/null 2>&1; then
  systemctl restart smartdns
elif command -v service >/dev/null 2>&1; then
  service smartdns restart
elif command -v rc-service >/dev/null 2>&1; then
  rc-service smartdns restart
elif [ -x "/etc/init.d/smartdns" ]; then
  /etc/init.d/smartdns restart
else
  echo "Please restart smartdns manually."
fi

echo "Cleaning up..."
[ -d "$WORKDIR" ] && rm -rf "$WORKDIR"
