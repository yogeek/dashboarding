# Inspired from https://github.com/visibilityspots/dockerfile-smashing
FROM ruby

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get update && \
    apt-get -y install nodejs && \
    apt-get -y clean
RUN gem install bundler smashing rest-client
RUN mkdir /smashing && \
    smashing new smashing && \
    cd /smashing && \
    bundle && \
    ln -s /smashing/dashboards /dashboards && \
    ln -s /smashing/jobs /jobs && \
    ln -s /smashing/assets /assets && \
    ln -s /smashing/lib /lib-smashing && \
    ln -s /smashing/public /public && \
    ln -s /smashing/widgets /widgets && \
    mkdir /smashing/config && \
    mv /smashing/config.ru /smashing/config/config.ru && \
    ln -s /smashing/config/config.ru /smashing/config.ru && \
    ln -s /smashing/config /config

COPY run.sh /

# VOLUME ["/dashboards", "/jobs", "/lib-smashing", "/config", "/public", "/widgets", "/assets"]

ENV PORT 3030
EXPOSE $PORT
WORKDIR /smashing

CMD ["/run.sh"]

# Add custom code
COPY ./dashboards /smashing/dashboards
COPY ./assets /smashing/assets
COPY ./jobs /smashing/jobs
COPY ./widgets /smashing/widgets
COPY ./config /smashing/config