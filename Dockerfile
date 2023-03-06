FROM nginx:stable-alpine

ENV TZ=America/Bogota
RUN apk update --no-cache && apk upgrade --no-cache 

RUN apk add --no-cache --virtual .build-deps \
    gcc musl-dev linux-headers bash tzdata  curl nginx

COPY ./mypersonalpage /usr/share/nginx/html
VOLUME /usr/share/nginx/html
VOLUME /etc/nginx
COPY . . 

EXPOSE 80


HEALTHCHECK --interval=20m --timeout=4s --start-period=30s --retries=5 \
CMD curl -f http://localhost:80 || exit 1
