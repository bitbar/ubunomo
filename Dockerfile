# bitbar/ubunomo

FROM bitbar/ubuno:1.0.0

LABEL vendor="Bitbar Inc" \
      description="Ubuntu LTS based Docker image with Node.js and MongoDB inside."

# installing apt packages
RUN apt-get update
RUN apt-get dist-upgrade -y

# installing MongoDB
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
RUN apt-get update
RUN apt-get install -y mongodb-org

# Copy mongod.conf
COPY mongod.conf /etc/mongod.conf

# entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
