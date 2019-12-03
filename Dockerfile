FROM debian:10-slim

RUN apt-get install openvpn

COPY start.sh

CMD /bin/bash start.sh
