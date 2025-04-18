#!/bin/bash

mkdir -p ../../_vol/nginx/ssl
mkdir -p ../../_vol/nginx/conf.d

# Generate self-signed SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ../../_vol/nginx/ssl/nginx.key -out ../../_vol/nginx/ssl/nginx.crt \
  -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

# Set permissions
chmod 644 ../../_vol/nginx/ssl/nginx.crt
chmod 600 ../../_vol/nginx/ssl/nginx.key

echo "SSL certificate generated successfully!"
