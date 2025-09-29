# Use official PHP-FPM image
FROM php:8.2-fpm

# Install Nginx and required packages
RUN apt-get update && apt-get install -y \
    nginx \
    vim \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy website files to web root
COPY . /var/www/html

# Set working directory
WORKDIR /var/www/html

# Remove default Nginx config and use our own
RUN rm /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 8088

# Start Nginx and PHP-FPM together
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
