FROM node:14.19.1-alpine

ENV TERM xterm
ENV TZ Asia/Taipei

RUN apk update && \
    apk --no-cache add nginx supervisor tzdata py3-jinja2

RUN npm cache clean -f && \
    npm install pm2@5.2.0 -g

RUN chown -R nobody:nobody /var/lib/nginx && \
    chown -R nobody:nobody /var/log/nginx

COPY ${SOURCE} ${DEST}

ENTRYPOINT []

WORKDIR ${DIR}

COPY . .

ARG SHA
RUN echo -n $SHA > ${FILE}

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
