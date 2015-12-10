FROM gliderlabs/alpine:latest
MAINTAINER Alexander Egorov <a.a.egoroff@gmail.com>
COPY ["app", "/"]
RUN ["./prepare.sh"]
EXPOSE 5678
CMD ["foreman", "start", "-d", "/sinatra"]
