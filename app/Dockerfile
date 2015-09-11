FROM debian:8.2
MAINTAINER Alexander Egorov <a.a.egoroff@gmail.com>

ENV LOCALE="en_US.UTF-8" RACK_USER="sinatra"

COPY ["prepare*.sh", "/"]
COPY ["sinatra", "/${RACK_USER}"]

RUN ["/prepare.sh"]

EXPOSE 4567
CMD ["gosu", "${RACK_USER}", "foreman", "start", "-d", "/sinatra"]
