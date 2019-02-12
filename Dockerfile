FROM node:10

ENV NODE_ENV production

ENV THELOUNGE_HOME "/var/opt/thelounge"
VOLUME "${THELOUNGE_HOME}"

# Expose HTTP.
ENV PORT 9000
EXPOSE ${PORT}

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["thelounge", "start"]

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Install thelounge.
ARG THELOUNGE_VERSION=3.0.1
RUN git clone https://github.com/shoghicp/thelounge.git /opt/thelounge && \
    cd /opt/thelounge && \
    NODE_ENV= yarn --non-interactive install && \
    NODE_ENV=production yarn --non-interactive build && \
    yarn --non-interactive cache clean
