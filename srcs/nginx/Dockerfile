FROM alpine:3.12

RUN	apk update --no-cache && \
	apk upgrade --no-cache && \
	apk add --no-cache nginx \
	openssl \
	openssh

COPY	srcs/nginx.conf		/etc/nginx/conf.d/default.conf
COPY	srcs/web			/www/
COPY	srcs/start.sh		/etc/start.sh

EXPOSE	80 443 22

CMD		ash /etc/start.sh