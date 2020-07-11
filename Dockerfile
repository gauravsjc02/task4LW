FROM httpd
COPY -RT KNIT webpages /usr/local/apache2/htdocs/
EXPOSE 80
