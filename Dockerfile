FROM debian:10-slim

RUN apt-get install openvpn iptables-persistent

COPY start.sh /root/start/sh

CMD /bin/bash /root/start.sh
