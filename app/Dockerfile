FROM gliderlabs/alpine:latest
MAINTAINER Alexander Egorov <a.a.egoroff@gmail.com>

COPY ["sinatra", "*.sh", "/app/"]
RUN ["/app/prepare.sh"]
EXPOSE 5678
CMD ["/app/all.sh"]
