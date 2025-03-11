# Intentionally vulnerable web application
FROM vulnerables/web-dvwa

# Expose the default web server port
EXPOSE 80

# Start the application
CMD ["apache2-foreground"]
