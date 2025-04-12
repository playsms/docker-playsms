#!/bin/bash

mkdir -p ../nginx/ssl
mkdir -p ../nginx/conf.d

# Generate self-signed SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ../nginx/ssl/nginx.key -out ../nginx/ssl/nginx.crt \
  -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

# Set permissions
chmod 644 ../nginx/ssl/nginx.crt
chmod 600 ../nginx/ssl/nginx.key

echo "SSL certificate generated successfully!"
