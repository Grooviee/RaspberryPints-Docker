FROM debian:stretch
MAINTAINER Automation Geek

EXPOSE 80

# Set Local Env
RUN locale-gen en_US.UTF-8
RUN LC_ALL=en_US.UTF-

# Update apt, install dependencies and cleanup.
RUN apt-get update && \
    apt-get install -qy git wget unzip apache2 php php-mysql php-mbstring libapache2-mod-php && \ 
    apt-get clean
     
# Fetch Raspberry Pints from rtlindne
RUN cd /var/www && \
    git clone https://github.com/rtlindne/RaspberryPints.git -b master Pints && \
    chown -R www-data:www-data /var/www/Pints

VOLUME /var/www/Pints/data

COPY etc/ /etc/

RUN chmod +x /etc/my_init.d/*
RUN find /etc/service -name run -exec chmod +x {} \;
