FROM alpine:3.4
MAINTAINER David Personette <dperson@gmail.com>

WORKDIR /

RUN apk --update --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add ca-certificates openssl tor privoxy bash && \
    mkdir -p /etc/tor/run && \
    chown -Rh tor. /var/lib/tor /etc/tor/run && \
    chmod 0750 /etc/tor/run
  
COPY torrc.default /etc/tor/torrc
COPY privoxy.conf /etc/privoxy/config
COPY torproxy.sh /
  
EXPOSE 8118 9050 9051
VOLUME ["/etc/tor", "/var/lib/tor"]

CMD ["/torproxy.sh"]
