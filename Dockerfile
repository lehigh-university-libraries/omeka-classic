ARG BASE_IMAGE=lehighlts/omeka-classic:3.2.1-php84@sha256:c172d098a7d160f983e6b659450ae413258da6785e3502f6eedfa410deabd918
FROM ${BASE_IMAGE}

WORKDIR /var/www/omeka-classic

# nginx:nginx in the base image.
COPY --link --chown=100:101 plugins/ /var/www/omeka-classic/plugins/
COPY --link --chown=100:101 themes/ /var/www/omeka-classic/themes/
