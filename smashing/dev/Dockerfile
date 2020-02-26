FROM ruby


#--------------------------- BEGIN gosu
# Gosu is user to avoid permission problem on file shared by bind-mounted docker volumes
# "dev" user will be mapped on the host user which owns the directory mounted as a volume when launching a container from this image

ENV USER=dev GROUP=dev

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.10
RUN set -x \
  && curl -sSLo /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
  && curl -sSLo /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
  && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu \
  && gosu nobody true
# A 'node' unprivileged user already exists in node base image
# If you change the base image, uncomment the following line
RUN groupadd -r $GROUP && useradd -m -r -g $GROUP $USER
RUN chown -R $USER:$GROUP /usr/local
COPY docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

#--------------------------- END gosu


# Smashing prerequisites
# https://github.com/Smashing/smashing/wiki/How-to:-Install-Smashing-on-Ubuntu-or-Debian
RUN apt-get update && \
    apt-get install -y sudo apt-utils \
            build-essential \
            nodejs && \
    apt-get -y clean

RUN gem install bundler smashing

RUN mkdir /home/dev/mysmashing
WORKDIR /home/dev/mysmashing