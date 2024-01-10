FROM alpine:3.19
# hadolint ignore=DL3018
RUN apk add --no-cache bash git inotify-tools openssh

RUN mkdir -p /app
WORKDIR /app
COPY gitwatch.sh ./ 

RUN chmod 755 -- *.sh

RUN git config --global credential.helper '!f() { test $1 = get && echo "username=$GIT_USER" && echo "password=$GIT_PASS"; }; f'
RUN git config --global --add safe.directory '*'
RUN git config --global --add --bool push.autoSetupRemote true

ENTRYPOINT ["./gitwatch.sh"]
