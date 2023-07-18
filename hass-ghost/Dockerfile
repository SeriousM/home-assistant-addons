# Changelog: https://github.com/monicahq/monica/blob/main/CHANGELOG.md
FROM ghost:5.54.3

RUN apt-get update && apt-get install -y \
    jq \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 80/tcp

WORKDIR /var/lib/ghost

COPY docker_prestep_entrypoint.sh /usr/local/bin/

ENTRYPOINT ["sh", "/usr/local/bin/docker_prestep_entrypoint.sh"]

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION
ARG IMAGE_SOURCE

# Labels
LABEL \
    io.hass.name="ghost" \
    io.hass.description="Turn your audience into a business." \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="SeriousM" \
    org.label-schema.description="Turn your audience into a business." \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="ghost" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://addons.community" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-example/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-example" \
    org.label-schema.vendor="SeriousM"\
    org.opencontainers.image.source=${IMAGE_SOURCE}
