FROM php:7.4.1-fpm
COPY php.ini /usr/local/etc/php/
RUN apt-get update \
  && apt-get install -y vim git libzip-dev zip unzip zlib1g-dev mariadb-client \
    && docker-php-ext-install zip pdo_mysql

RUN pecl install xdebug \
  && docker-php-ext-enable xdebug

RUN touch /tmp/xdebug.log && chmod 777 /tmp/xdebug.log

##Composer install
#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
##もし corrupt するときは https://getcomposer.org/download/ から新しいハッシュ値をコピペして
#RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'c5b9b6d368201a9db6f74e2611495f369991b72d9c8cbd3ffbc63edff210eb73d46ffbfce88669ad33695ef77dc76976') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
#RUN php composer-setup.php
#RUN php -r "unlink('composer-setup.php');"
#RUN mv composer.phar /usr/local/bin/composer

# composerをインストール
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin

# PhpDocumentorインストール#本番環境で入れるな。
RUN php -d memory_limit=-1 /usr/local/bin/composer global require phpdocumentor/phpdocumentor
RUN apt-get install -y graphviz*

# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

# yarnをインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
#RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/+sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

WORKDIR /src

