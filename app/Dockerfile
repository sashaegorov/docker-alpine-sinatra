FROM gliderlabs/alpine:latest
MAINTAINER Alexander Egorov <a.a.egoroff@gmail.com>

COPY ["sinatra", "prepare*.sh", "/app/"]
RUN ["/app/prepare.sh"]
EXPOSE 4567
CMD ["foreman", "start", "-d", "/app"]
