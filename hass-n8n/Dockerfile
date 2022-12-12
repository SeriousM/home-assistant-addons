ARG N8N_VERSION=0.205.0

FROM n8nio/n8n:${N8N_VERSION}

#COPY docker-entrypoint.sh /docker-entrypoint.sh

# hassio is mapping the persistent folder to /data so we need to tell n8n that
ENV N8N_USER_FOLDER="/data/n8n"
