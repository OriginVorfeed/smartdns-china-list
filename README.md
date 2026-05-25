# smartdns-china-list

你好，欢迎来到 Vorfeed 的欢乐满满翻墙提高班。

本项目是 **SmartDNS、Xray、Shadowrocket、SingBox** 统一分流规则的一部分，通过严格同步 [dnsmasq-china-list](https://github.com/felixonmars/dnsmasq-china-list)，保证多端分流规则的一致性。

- Shadowrocket 规则：[shadowrocket-china-list](https://github.com/OriginVorfeed/shadowrocket-china-list)

- Xray 规则：[xray-china-list](https://github.com/OriginVorfeed/xray-china-list)

- SingBox 规则：[singbox-china-list](https://github.com/OriginVorfeed/singbox-china-list)

## 规则说明

定时执行 dnsmasq-china-list 自带的 [Makefile](https://github.com/felixonmars/dnsmasq-china-list/blob/master/Makefile) 脚本，转换为对应的 **SmartDNS 规则**。

每套规则提供2个链接，第1个需要代理才能稳定访问，第2个可以直接访问，但会延迟12小时。

- **accelerated-domains.china.smartdns.conf**：
  - [https://raw.githubusercontent.com/OriginVorfeed/smartdns-china-list/master/accelerated-domains.china.smartdns.conf](https://raw.githubusercontent.com/OriginVorfeed/smartdns-china-list/master/accelerated-domains.china.smartdns.conf)
  - [https://cdn.jsdelivr.net/gh/OriginVorfeed/smartdns-china-list@master/accelerated-domains.china.smartdns.conf](https://cdn.jsdelivr.net/gh/OriginVorfeed/smartdns-china-list@master/accelerated-domains.china.smartdns.conf)
- **apple.china.smartdns.conf**：
  - [https://raw.githubusercontent.com/OriginVorfeed/smartdns-china-list/master/apple.china.smartdns.conf](https://raw.githubusercontent.com/OriginVorfeed/smartdns-china-list/master/apple.china.smartdns.conf)
  - [https://cdn.jsdelivr.net/gh/OriginVorfeed/smartdns-china-list@master/apple.china.smartdns.conf](https://cdn.jsdelivr.net/gh/OriginVorfeed/smartdns-china-list@master/apple.china.smartdns.conf)
- **google.china.smartdns.conf**：
  - [https://raw.githubusercontent.com/OriginVorfeed/smartdns-china-list/master/google.china.smartdns.conf](https://raw.githubusercontent.com/OriginVorfeed/smartdns-china-list/master/google.china.smartdns.conf)
  - [https://cdn.jsdelivr.net/gh/OriginVorfeed/smartdns-china-list@master/google.china.smartdns.conf](https://cdn.jsdelivr.net/gh/OriginVorfeed/smartdns-china-list@master/google.china.smartdns.conf)
- **bogus-nxdomain.china.smartdns.conf**：
  - [https://raw.githubusercontent.com/OriginVorfeed/smartdns-china-list/master/bogus-nxdomain.china.smartdns.conf](https://raw.githubusercontent.com/OriginVorfeed/smartdns-china-list/master/bogus-nxdomain.china.smartdns.conf)
  - [https://cdn.jsdelivr.net/gh/OriginVorfeed/smartdns-china-list@master/bogus-nxdomain.china.smartdns.conf](https://cdn.jsdelivr.net/gh/OriginVorfeed/smartdns-china-list@master/bogus-nxdomain.china.smartdns.conf)

## 使用方法

- 修改 [smartdns.conf 配置文件](https://pymumu.github.io/smartdns/configuration/)

  ```conf
  # 这3套规则里的域名不太会被 DNS 污染，推荐一起使用，提升直连体验。
  conf-file /root/dnsmasq-china-list/accelerated-domains.china.smartdns.conf
  conf-file /root/dnsmasq-china-list/apple.china.smartdns.conf
  conf-file /root/dnsmasq-china-list/google.china.smartdns.conf

  # 过滤假冒 IP 地址，不推荐使用。
  # 自建 DNS 的目标是获取未被 DNS 污染的 IP 地址。如果解析到假冒 IP 地址，解决方法应该是优化分流配置，而不是简单过滤。
  conf-file /root/dnsmasq-china-list/bogus-nxdomain.china.smartdns.conf

  # -group china：定时生成规则的组名，固定为 china。
  # -exclude-default-group：将这条 DNS 配置从默认组中排除，仅用于解析 china 组的域名。
  server 223.5.5.5 -group china -exclude-default-group

  # 不会解析 china 或任何指定了组名的域名。
  # -proxy proxy：各种海外 DNS 可谓是 DNS 污染的重灾区，通过设置代理，可以完美解决此类问题。
  # 同时还能防止海外 DNS 泄露给本地 ISP，可谓一举两得。
  # -subnet 117.76.117.0/24：需改成自己的公网 IP，并把第4个数字改为0。一定要改，不然不生效。
  # 通过代理访问海外 DNS 时，解析到的 IP 也是海外的。设置 subnet 后，可以让海外 DNS 尝试返回 subnet 所在地区的 IP。
  server 8.8.8.8 -proxy proxy -subnet 117.76.117.0/24

  # 设置访问海外 DNS 的代理。如果上游为 UDP DNS，代理需支持 UDP 转发。
  proxy-server socks5://127.0.0.1:1080 -name proxy
  ```

- 按需下载 [规则说明](#规则说明) 里的规则，并放置在 `/root/dnsmasq-china-list/` 目录内。
- 重启 SmartDNS 后，你就拥有了一台杜绝 DNS 污染，且海外 DNS 不会泄露给本地 ISP 的自建 DNS。

## 定时任务脚本

虽然白名单分流的一大好处就在于，就算不更新也能保持比较好的直连体验。

但如果你愿意配置自己的定时任务，就能自定义那个固定为 china 的组名。

```bash
#!/bin/bash
set -e

# SmartDNS 组名，在这里自定义
GROUP="china"
# 配置文件路径，可以自行修改
CONFDIR="/root/dnsmasq-china-list"
# dnsmasq-china-list 下载链接，可以按需替换成镜像站链接
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
```

## 验证配置

 - 开启 SmartDNS 日志

  ```conf
  log-level info
  log-console yes
  ```

 - 进行以下测试：

  ```shell
  nslookup google.com 127.0.0.1
  journalctl -eu smartdns | grep google.com | grep group
  # 结果应包含 group: default，不应包含 group: china

  nslookup baidu.com 127.0.0.1
  journalctl -eu smartdns | grep baidu.com | grep group
  # 结果应包含 group: china，不应包含 group: default
  ```
 
## 常见问题

- **proxy + subnet 那么美好，还需要分流吗？**

  需要。大部分 proxy 本身也需要域名解析，分流是不可避免的。

  海外 DNS 只是“尝试”返回 subnet 所在地区的 IP，并不一定准确，无法完全替代分流。

## 问题反馈

任何问题欢迎在 [Issues](https://github.com/OriginVorfeed/smartdns-china-list/issues) 中反馈。
