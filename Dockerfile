FROM php:7.4-cli-alpine
COPY grav /var/www/grav
WORKDIR /var/www/grav

RUN mv php.ini "$PHP_INI_DIR/php.ini" \
 && adduser -S -G www-data grav \
 && chown -R grav:www-data /var/www/grav "$PHP_INI_DIR/php.ini" \
 && find /var/www/grav -type d -exec chmod 755 {} + \
 && find /var/www/grav -type f -exec chmod 664 {} + \
 && chmod +x /var/www/grav/bin/* \
 && apk upgrade --no-cache \
 && apk add --no-cache libzip-dev libpng-dev \
 && docker-php-ext-install zip gd

USER grav

RUN php bin/composer.phar install --no-dev -o \
 && rm -fR /home/grav/.composer \
 && bin/gpm install -y admin git-sync

EXPOSE 8080
CMD [ "php", "-S", "0.0.0.0:8080", "system/router.php" ]