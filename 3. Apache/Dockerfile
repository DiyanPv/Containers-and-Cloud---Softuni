# Use the official Apache image from Docker Hub
FROM httpd

VOLUME {PWD}:/usr/local/apache2/htdocs/

EXPOSE 80

# Configure Docker to listen on port 3001 when accessed from localhost
ENV URL=http://localhost:8080
EXPOSE 3001
