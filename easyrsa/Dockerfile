FROM alpine:latest

RUN apk add --no-cache --upgrade openssl tar && \
    addgroup -g 101 radius && \
    adduser -u 100 -D -G radius radius

WORKDIR /easyrsa
COPY entrypoint.sh .
RUN wget -qO- https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.8/EasyRSA-3.0.8.tgz | tar xvz --strip-components=1 && \
    chmod u+x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
CMD ["help"]
