FROM httpd
COPY -RT /knitwebpages /usr/local/apache2/htdocs/
EXPOSE 80
