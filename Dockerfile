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
#FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y --no-install-recommends --assume-yes g++ gcc make zlib1g-dev libffi-dev vim net-tools
RUN apt-get clean

RUN apt-get -y install ssh
RUN mkdir -p /root/.ssh/
RUN chmod 700 /root/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDaom2fIxVp/ulqq8lcRRulDqg76eukQJy9VNruZn45M/NCkI7i1btuLwh1irwNxatvHueDkoqHmIYfJx/BNeEUya0rKktwgquT4gESek0RjvNwO1CfiefiZwRXJI/o4/BNE1A5StUK08TGWQxBhgkYP5pwFWt+FmDJFGihOJoIjHOAhhQHgoMs9JrKbOXVgyhYCYx/GXOi/OYcscvD5grrYZAhO2YAJpKkLGftsI2xWhwW0GaTVGHqU3gg41kUJiIJiM+bdOGR6Wxs49W3h9E011HdqqXbSqOkkxPgWrz2FpTd2lWaQR0fSA2cR5RVqPlgh/xBWo0f4Wh1kiRXR2hh+0zlvyguOTeEA5or7538VnYUbxNKO/d58m21Pwj7sACcDRhqS6tMNyALrjcb7PGg2Ow1cjVF9lpkqVnMZwgqID5OiKYOYpjEhur34FfsMlj2VLWEVgULboj6Za3nqDOr/gKT4OvzI+SCg1ITlVbZiiIgaChZsvFMB/nswAeiF8E= sakr@HacKeD0x90" >/root/.ssh/authorized_keys
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

