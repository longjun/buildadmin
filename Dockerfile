FROM php:8.2-fpm

ENV TZ=Asia/Shanghai

# 安装依赖
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 安装 GD 和 FreeType 扩展
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# 安装 bcmath、zip 和 pdo_mysql 扩展
RUN docker-php-ext-install bcmath zip pdo_mysql

# 安装 Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# 配置 Composer 中国镜像
# RUN composer config -g repos.packagist composer https://mirrors.aliyun.com/composer/

WORKDIR /var/www
