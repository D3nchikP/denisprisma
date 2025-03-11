# Use an outdated, vulnerable base image
FROM debian:stretch

# Install vulnerable packages
RUN apt-get update && apt-get install -y \
    openssl \
    curl \
    apache2 \
    --no-install-recommends

# Start a simple command
CMD ["echo", "This is a vulnerable container!"]
