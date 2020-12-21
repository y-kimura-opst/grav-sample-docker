FROM docker.pkg.github.com/y-kimura-opst/grav-sample/base:main
RUN rm -fR /var/www/grav/user
COPY --chown=grav:www-data grav/user /var/www/grav/user
WORKDIR /var/www/grav
