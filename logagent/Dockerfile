FROM node:8.12-alpine

RUN apk add --update bash tini && rm -rf /var/cache/apk/*

RUN npm install -g --unsafe-perm @sematext/logagent
RUN mkdir -p /etc/sematext

COPY patterns.yml /etc/sematext/patterns.yml
COPY logagent.conf /etc/sematext/logagent.conf
COPY start.sh /start.sh

RUN chmod +x /start.sh

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/start.sh"]
