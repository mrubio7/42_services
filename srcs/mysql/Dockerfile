FROM		alpine:3.12

RUN			RUN	apk update --no-cache && \
			apk upgrade --no-cache && \
			apk add --no-cache mysql

COPY		./srcs/my.cnf /var/lib/mysql/

CMD			./srcs/start.sh