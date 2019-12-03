#!/bin/bash

# loopback
/usr/sbin/iptables -A INPUT -i lo -j ACCEPT
/usr/sbin/iptables -A OUTPUT -o lo -j ACCEPT

# In from LAN
/usr/sbin/iptables -I INPUT -i eth0 -j ACCEPT

# Out to VPN
/usr/sbin/iptables -I OUTPUT -o tun+ -j ACCEPT

# OpenVPN
/usr/sbin/iptables -A OUTPUT -o eth0 -p udp --dport 1198 -j ACCEPT

# ntp
/usr/sbin/iptables -A OUTPUT -o eth0 -p udp --dport 123 -j ACCEPT

# dhcp
/usr/sbin/iptables -A OUTPUT -p UDP --dport 67:68 -j ACCEPT

# dns
/usr/sbin/iptables -A OUTPUT -o eth0 -p udp --dport 53 -j ACCEPT

/usr/sbin/iptables -A FORWARD -i tun+ -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT

# LAN out to VPN
/usr/sbin/iptables -A FORWARD -i eth0 -o tun+ -j ACCEPT
/usr/sbin/iptables -t nat -A POSTROUTING -o tun+ -j MASQUERADE

/usr/sbin/openvpn --config /etc/openvpn/${VPNCONF:-vpn.conf}
