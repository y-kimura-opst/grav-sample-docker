FROM php:7.4-cli-alpine

RUN apk upgrade --no-cache \
 && apk add --no-cache libzip-dev libpng-dev git \
 && docker-php-ext-install zip gd

COPY grav /var/www/grav
COPY bin /var/www/grav/bin
WORKDIR /var/www/grav

RUN ls -l

RUN mv php.ini "$PHP_INI_DIR/php.ini" \
 && adduser -S -G www-data grav \
 && chown -R grav:www-data /var/www/grav "$PHP_INI_DIR/php.ini" \
 && find /var/www/grav -type d -exec chmod 755 {} + \
 && find /var/www/grav -type f -exec chmod 664 {} + \
 && chmod +x /var/www/grav/bin/*

USER grav

RUN php bin/composer.phar install --no-dev -o \ 
 && rm -fR /home/grav/.composer \
 && bin/gpm install -y admin git-sync

EXPOSE 8080
CMD [ "/var/www/grav/bin/run.sh" ]