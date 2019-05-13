FROM alpine:latest

RUN apk add --no-cache freeradius freeradius-eap openssl

ENV PRIVATE_CERT=issued/server.crt PRIVATE_KEY=private/server.key \
    CA_CERT=ca.crt DH_FILE=dh.pem

COPY radiusd.conf clients.conf /etc/raddb/
COPY eap /etc/raddb/mods-enabled
COPY site /etc/raddb/sites-available
#copy server keys to docker container
COPY private/server.key /etc/raddb/certs/private/

RUN rm /etc/raddb/sites-enabled/* && \
    ln -s /etc/raddb/sites-available/site /etc/raddb/sites-enabled/site && \
    mkdir /tmp/radiusd && \
    chown radius:radius /tmp/radiusd

VOLUME /etc/raddb/certs
RUN chgrp -R radius /etc/raddb/

EXPOSE 1812/udp
USER radius

ENTRYPOINT ["/usr/sbin/radiusd"]
CMD ["-X", "-f"]
