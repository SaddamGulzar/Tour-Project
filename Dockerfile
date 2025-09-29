# Use official PHP-FPM image
FROM php:8.2-fpm

# Install Nginx
RUN apt-get update && apt-get install -y \
    nginx \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy website files
COPY . /var/www/html

# Set working directory
WORKDIR /var/www/html

# Remove default Nginx site config and copy our own
RUN rm /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 8088
EXPOSE 8088

# Start PHP-FPM and Nginx in the foreground
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
