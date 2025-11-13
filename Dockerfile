
FROM node:18-alpine

ENV USE_LOCAL=false \
    GIT_REPO="https://github.com/AxelOsip/test"

RUN apk add --no-cache git
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN dos2unix entrypoint.sh

CMD ["sh", "-c", "while true; do pwd; /entrypoint.sh || echo 'App crashed — retrying in 5s'; sleep 5; done"]
