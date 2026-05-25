# smartdns-china-list

你好，欢迎来到Vorfeed的欢乐满满翻墙提高班。

本项目是**SmartDNS、Xray、Shadowrocket、SingBox**统一分流规则的一部分，通过严格同步[dnsmasq-china-list](https://github.com/felixonmars/dnsmasq-china-list)，保证多端分流规则的一致性。

- Shadowrocket规则：[shadowrocket-china-list](https://github.com/OriginVorfeed/shadowrocket-china-list)

- Xray规则：[xray-china-list](https://github.com/OriginVorfeed/xray-china-list)

- SingBox规则：[singbox-china-list](https://github.com/OriginVorfeed/singbox-china-list)

## 规则说明

定时执行dnsmasq-china-list自带的[Makefile](https://github.com/felixonmars/dnsmasq-china-list/blob/master/Makefile)脚本，转换为对应的**SmartDNS规则**。

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
  # -exclude-default-group：将 DNS 服务器从默认组中排除，仅用于解析 china 组的域名。
  server 223.5.5.5 -group china -exclude-default-group

  # 不会解析 china 或任何指定了组名的域名。
  # -proxy proxy：各种海外 DNS 可谓是 DNS 污染的重灾区，通过设置代理，可以完美解决此类问题。
  # -subnet 117.76.117.0/24：需改成自己的公网 IP，并把第4个数字改为0。
  # 通过代理访问海外 DNS 时，解析到的 IP 也是海外的。设置 subnet 后，可以让海外 DNS 尝试返回 subnet 所在地区的 IP。
  server-tls 8.8.8.8 -proxy proxy -subnet 117.76.117.0/24

  # 设置访问海外 DNS 的代理。如果上游为 UDP DNS，需要代理也支持 UDP 协议。
  proxy-server socks5://127.0.0.1:1080 -name proxy
  ```

- 按需下载 [规则说明](#规则说明) 里的规则，并放置在 `/root/dnsmasq-china-list/` 目录内。
- 重启 SmartDNS。

## 常见问题

- **proxy + subnet 那么美好，还需要分流吗？**

  需要。大部分 proxy 本身也需要域名解析，分流是不可避免的。

  海外 DNS 只是“尝试”返回 subnet 所在区域的 IP，并不一定准确，无法完全替代分流。

## 问题反馈

任何问题欢迎在 [Issues](https://github.com/OriginVorfeed/smartdns-china-list/issues) 中反馈。
