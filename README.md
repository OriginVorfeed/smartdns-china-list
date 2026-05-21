# smartdns-china-list

你好，欢迎来到Vorfeed的欢乐满满翻墙提高班。

本项目是**自建DNS、Xray、小火箭**统一分流规则的一部分，通过严格同步[dnsmasq-china-list](https://github.com/felixonmars/dnsmasq-china-list)，保证多端分流规则的一致性。

- 小火箭规则：[shadowrocket-china-list](https://github.com/OriginVorfeed/shadowrocket-china-list)

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

对于自建DNS，我们的目标

## 问题反馈

任何问题欢迎在 [Issues](https://github.com/OriginVorfeed/shadowrocket-china-list/issues) 中反馈。
