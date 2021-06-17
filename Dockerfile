FROM busybox

ENV VER=2.11.1 METHOD=aes-128-gcm PASSWORD=secret DNS=1.1.1.1
ENV PORT=2080

RUN mkdir -p /opt \
  && wget https://github.com/ginuerzh/gost/releases/download/v${VER}/gost-linux-amd64-${VER}.gz \
  && gzip -d gost-linux-amd64-${VER}.gz \
  && mv gost-linux-amd64-${VER} /opt/gost \
  && chmod a+x /opt/gost

WORKDIR /opt
EXPOSE $PORT

CMD exec /opt/gost -L="ss+mws://$METHOD:$PASSWORD@:$PORT?dns=$DNS"
