FROM node:5
ADD ./sources.list /etc/apt/sources.list
RUN git clone https://github.com/wikimedia/restbase.git && cd restbase && git checkout v0.14.1 && rm -Rfv .git/

WORKDIR restbase

RUN npm install && rm -Rf /tmp/npm-* /root/.npm/

EXPOSE 7231

RUN mkdir /db
RUN chmod 777 /db

ADD ./wikitolearn.yaml /restbase/projects/
ADD ./mathoid.yaml /restbase/v1/mathoid.yaml
ADD ./mathoid.js /restbase/sys/mathoid.js


ADD ./kickstart.sh /
RUN chmod +x /kickstart.sh
CMD /kickstart.sh
