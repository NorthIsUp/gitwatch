FROM alpine:3.19
# hadolint ignore=DL3018
RUN apk add --no-cache bash git inotify-tools openssh

RUN mkdir -p /app
WORKDIR /app
COPY gitwatch.sh ./ 

RUN chmod 755 -- *.sh

RUN git config --global credential.helper '!f() { sleep 1; echo "username=$GITHUB_USER" ; echo "token=$GITHUB_TOKEN"; }; f'
RUN git config --global --add safe.directory '*'

ENTRYPOINT ["./gitwatch.sh"]
