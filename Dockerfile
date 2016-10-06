FROM node:5
ADD /src/docker-npm-install.sh /docker-npm-install.sh

RUN git clone https://github.com/wikimedia/restbase.git && cd restbase && git checkout v0.15.2 && rm -Rfv .git/

WORKDIR restbase

RUN /docker-npm-install.sh

EXPOSE 7231

RUN mkdir /db
RUN chmod 777 /db

ADD ./src/restbase/sys/mathoid.js /restbase/sys/
ADD ./src/restbase/v1/mathoid.yaml /restbase/v1/
ADD ./src/restbase/projects/wikitolearn.yaml /restbase/projects/

ADD ./src/make-config-yaml.sh /
ADD ./src/docker-entrypoint.sh /
ENTRYPOINT /docker-entrypoint.sh
