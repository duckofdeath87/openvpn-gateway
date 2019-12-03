FROM debian:10-slim

RUN apt-get update
RUN apt-get install -y openvpn iptables-persistent

COPY start.sh /root/start.sh

CMD /bin/bash /root/start.sh
