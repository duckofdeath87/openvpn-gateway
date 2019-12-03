FROM kylemanna/docker-openvpn
COPY iptables.conf
COPY start.sh

CMD /bin/bash start.sh
