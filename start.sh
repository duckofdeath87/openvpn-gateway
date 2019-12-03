iptables -A INPUT -i lo -m comment --comment "loopback" -j ACCEPT
iptables -A OUTPUT -o lo -m comment --comment "loopback" -j ACCEPT
iptables -I INPUT -i eth0 -m comment --comment "In from LAN" -j ACCEPT
iptables -I OUTPUT -o tun+ -m comment --comment "Out to VPN" -j ACCEPT
iptables -A OUTPUT -o eth0 -p udp --dport 1198 -m comment --comment "openvpn" -j ACCEPT
iptables -A OUTPUT -o eth0 -p udp --dport 123 -m comment --comment "ntp" -j ACCEPT
iptables -A OUTPUT -p UDP --dport 67:68 -m comment --comment "dhcp" -j ACCEPT
iptables -A OUTPUT -o eth0 -p udp --dport 53 -m comment --comment "dns" -j ACCEPT
iptables -A FORWARD -i tun+ -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -o tun+ -m comment --comment "LAN out to VPN" -j ACCEPT
iptables -t nat -A POSTROUTING -o tun+ -j MASQUERAD

ovpn_run
