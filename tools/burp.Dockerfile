FROM openjdk:11-jre-slim

RUN apt install -y curl

RUN addgroup --system burp && \
  adduser --system --ingroup burp burp

RUN curl https://portswigger.net/burp/releases/download \
  -o burpsuite_community.jar

USER burp

ARG PROJECT_CONFIG="$HOME/config/project_options.json"
ARG USER_CONFIG="$HOME/config/user_options.json"

ENTRYPOINT [java -jar "$@" --config-file="$PROJECT_CONFIG" --user-config-file="$USER_CONFIG"]