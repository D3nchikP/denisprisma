# Use an outdated, vulnerable base image
FROM debian:stretch

# Switch to the Debian archive for package installation
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list && \
    echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/99no-check-valid-until && \
    apt-get update && \
    apt-get install -y \
    openssl \
    curl \
    apache2 \
    --no-install-recommends

# Start a simple command
CMD ["echo", "This is a vulnerable container!"]
