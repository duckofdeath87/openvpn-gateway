FROM debian:10-slim

RUN apt-get install openvpn iptables-persistent

COPY start.sh

CMD /bin/bash start.sh
