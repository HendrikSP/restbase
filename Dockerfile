FROM node:5
ADD ./docker-npm-install.sh /docker-npm-install.sh

ADD ./sources.list /etc/apt/sources.list
WORKDIR /opt

RUN git clone https://github.com/wikimedia/restbase.git . && git checkout v0.16.2 && rm -Rfv .git/

RUN /docker-npm-install.sh

EXPOSE 7231

RUN mkdir /db
RUN chmod 777 /db

ADD ./wikitolearn.yaml /opt/projects/
ADD ./mathoid.yaml /opt/v1/mathoid.yaml
ADD ./mathoid.js /opt/sys/mathoid.js


ADD ./kickstart.sh /
RUN chmod +x /kickstart.sh
CMD /kickstart.sh
