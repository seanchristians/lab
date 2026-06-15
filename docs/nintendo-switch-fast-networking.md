# Increasing Nintendo Switch network speed

Maximum observed download speed after improvements is just over 200Mbps. This limitation is caused by the outdated networking card in the device. By default, the Switch will not attain this speed. Here's what I did to unlock it.

1. Increase wired link speed to at least 200Mbps
2. Set up local HTTP proxy (https://www.reddit.com/r/NintendoSwitch/comments/gswl20/solution_slow_eshop_downloads_on_nintendo_switch/)

In the OpenWRT router I installed [Tinyproxy](https://openwrt.org/docs/guide-user/services/proxy/tinyproxy). In the LuCI app settings (Services > Tinyproxy), add the LAN IP range to "Allowed clients" and delete all configured "Allowed connected ports." Create a firewall rule to accept input from LAN clients on the Tinyproxy listen port over TCP.

With Tinyproxy set up, configure the Switch's wired network to use the proxy. No authentication is required.
