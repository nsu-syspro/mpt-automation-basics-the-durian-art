FROM ubuntu:22.04

RUN apt-get update && apt-get install -y make gcc jq

WORKDIR /app
COPY . .

RUN make check

ENTRYPOINT ["sh", "-c", "./build/$(jq -r .name config.json) \"$@\"", "--"]
