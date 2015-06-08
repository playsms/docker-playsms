FROM tutum/lamp:latest
MAINTAINER Anton Raharja <antonrd@gmail.com>

# Install plugins
RUN apt-get update && \
  apt-get -y install php5-gd php5-mcrypt php5-imap php5-curl && \
  rm -rf /var/lib/apt/lists/*

# Download latest version of Wordpress into /app
RUN rm -fr /app && git clone --branch 1.0 --depth=1 https://github.com/antonraharja/playSMS.git /app

# Configure Wordpress to connect to local DB
ADD install.conf /app/install.conf

# Modify permissions to allow plugin upload
RUN chown -R www-data:www-data /app/* /var/www/html

# Add database setup script
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD create_db.sh /create_db.sh
RUN chmod +x /*.sh


EXPOSE 80 3306
CMD ["/run.sh"]

CMD ["cd /app && ./install-playsms.sh"]
