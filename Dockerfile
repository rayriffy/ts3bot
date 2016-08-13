FROM node:6.2.2

ARG TS3CLIENT_VERSION=3.0.19.4
ARG TS3BOT_COMMIT=4ab1de5a5e5f969982b114713cac35265fda6ef0

# Add "app" user
RUN mkdir -p /tmp/empty &&\
	groupadd -g 9999 app &&\
	useradd -d /home/app -l -N -g app -m -k /tmp/empty -u 9999 app &&\
	rmdir /tmp/empty

ADD setup.sh /
COPY src/ /home/app/src/
RUN sed -i 's,\r,,g' /setup.sh &&\
	sh /setup.sh

# Copy over configuration for other daemons
COPY etc/ /etc

# Startup configuration
WORKDIR /home/app
USER app
CMD [ "ts3bot", "--ts3-install-path=/home/app/ts3client" ]
