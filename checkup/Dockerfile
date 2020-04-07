FROM golang:1.13.7 AS checkup

# Get checkup
RUN go get -v -u github.com/sourcegraph/checkup/cmd/checkup && \
    chmod +x /go/bin/checkup && \
    mkdir /app && \
    cp /go/bin/checkup /app/ && \
    cp -r /go/src/github.com/sourcegraph/checkup/statuspage /app/web/ && \
    mkdir /app/web/storage

# Set config
COPY ./config.js /app/web/js
COPY ./checkup.json /app/checkup.json
COPY ./index.html /app/web/index.html

WORKDIR /app/
ENTRYPOINT [ "/app/checkup" ]