FROM debian:buster
MAINTAINER Grooviee

EXPOSE 80

# Update apt, install dependencies and cleanup.
RUN apt-get update && \
    apt-get install -qy git wget unzip curl nano apache2 php php-mysql php-mbstring php-curl libapache2-mod-php default-mysql-client && \ 
    apt-get clean

# Fetch Raspberry Pints from rtlindne
RUN cd /var/www && \
    git clone https://github.com/Grooviee/RaspberryPints.git -b master Pints && \
    chown -R www-data:www-data /var/www/Pints

COPY etc/ /etc/

CMD /etc/init.d/apache2 start && \ 
    tail -f /dev/null
