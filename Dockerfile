FROM httpd
COPY -RT KNIT webpage /usr/local/apache2/htdocs/
EXPOSE 80
