FROM beevelop/base

RUN apt-get update && apt-get install -y curl gnupg2 lsb-release && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    apt-key fingerprint 1655A0AB68576280 && \
    export VERSION=node_14.x && \
    export DISTRO="$(lsb_release -s -c)" && \
    echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | tee /etc/apt/sources.list.d/nodesource.list && \
    echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | tee -a /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install -y nodejs && \
    node -v && npm -v && \
    npm install -g yarn && \
    yarn -v && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN apt-get update
RUN apt-get install -y --no-install-recommends --assume-yes g++ gcc make zlib1g-dev libffi-dev vim net-tools
RUN apt-get clean

RUN apt-get -y install ssh
RUN mkdir -p /root/.ssh/
RUN chmod 700 /root/.ssh
#Add your publish ssh key here
RUN echo " " >/root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys
#RUN apt install -y nodejs
#RUN apt install -y npm
RUN mkdir -p /root/prototype
WORKDIR /root/prototype/
RUN npm init -y
RUN npm install lodash@4.6.1
RUN npm install jquery
RUN npm install express@4.17.1
RUN npm install body-parser@1.20.2



COPY src/vuln /root/prototype/vuln
WORKDIR /root/

RUN service ssh start
COPY src/service.sh /opt/service.sh
CMD ["/opt/service.sh"]

