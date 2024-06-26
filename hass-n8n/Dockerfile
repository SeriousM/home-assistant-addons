ARG NODE_VERSION=20
FROM node:${NODE_VERSION}-alpine

# https://www.npmjs.com/package/n8n?activeTab=versions
# https://github.com/n8n-io/n8n/blob/master/CHANGELOG.md
ARG N8N_VERSION=1.40.0

RUN if [ -z "$N8N_VERSION" ] ; then echo "The N8N_VERSION argument is missing!" ; exit 1; fi

# Update everything and install needed dependencies
RUN apk add --no-cache --update graphicsmagick tzdata git su-exec jq sqlite

# # Set a custom user to not have n8n run as root
USER root

# Install n8n and the also temporary all the packages
# it needs to build it correctly.
RUN apk --update add --virtual build-dependencies python3 build-base ca-certificates && \
    npm_config_user=root npm install -g sqlite3 --save && \
    npm_config_user=root npm install -g npm@latest full-icu n8n@${N8N_VERSION} && \
    apk del build-dependencies

# Install fonts
RUN apk --no-cache add --virtual fonts msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f && \
    apk del fonts && \
    find  /usr/share/fonts/truetype/msttcorefonts/ -type l -exec unlink {} \;

ENV NODE_ICU_DATA /usr/local/lib/node_modules/full-icu

WORKDIR /data

# https://docs.n8n.io/hosting/scaling/execution-data/#enable-data-pruning
ENV EXECUTIONS_DATA_PRUNE=true
# 14 days
ENV EXECUTIONS_DATA_MAX_AGE=336
ENV EXECUTIONS_DATA_PRUNE_MAX_COUNT=50000

COPY docker-entrypoint.sh /tmp/docker-entrypoint.sh
ENTRYPOINT ["sh", "/tmp/docker-entrypoint.sh"]

EXPOSE 5678/tcp


# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION
ARG IMAGE_SOURCE

# Labels
LABEL \
    io.hass.name="n8n" \
    io.hass.description="Automate without limits" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="SeriousM" \
    org.label-schema.description="Automate without limits" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="n8n" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://addons.community" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-example/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-example" \
    org.label-schema.vendor="SeriousM"\
    org.opencontainers.image.source=${IMAGE_SOURCE}