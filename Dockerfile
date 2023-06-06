# bitbar/ubunomo

FROM bitbar/ubuno:3.0.0

LABEL vendor="Bitbar Inc" \
      description="Ubuntu LTS based Docker image with Node.js and MongoDB inside."

# installing apt packages
RUN apt-get update
RUN apt-get dist-upgrade -y

# installing MongoDB
RUN curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
   gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor
RUN echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list
RUN apt update
RUN apt install -y mongodb-org

# setup MongoDB database dir
RUN mkdir -p /data/db
RUN chown `id -u` /data/db

# Copy mongod.conf
COPY mongod.conf /etc/mongod.conf

# Test
RUN mongod --fork --config /etc/mongod.conf; \
    mongosh

# entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
