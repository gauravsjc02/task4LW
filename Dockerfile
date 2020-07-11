FROM httpd
COPY /root/knit /usr/local/apache2/htdocs/
EXPOSE 80
