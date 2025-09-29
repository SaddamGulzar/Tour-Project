# Use the official PHP-FPM image with Nginx
FROM php:8.2-fpm

# Install Nginx and supervisor
RUN apt-get update && apt-get install -y nginx supervisor && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy website files
COPY . /var/www/html

# Set working directory
WORKDIR /var/www/html

# Configure Nginx
RUN rm /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 8088

# Start supervisord to run both nginx and php-fpm
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
