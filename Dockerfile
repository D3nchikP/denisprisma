# Use an outdated, vulnerable base image
FROM debian:stretch

# Fix outdated package repository and prevent expiration issues
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list && \
    echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/99no-check-valid-until && \
    apt-get update && \
    apt-get -y --allow-downgrades --allow-remove-essential --allow-change-held-packages install \
    libcurl3 \
    libldap-2.4-2 \
    librtmp1 \
    openssl \
    curl \
    apache2-bin \
    apache2 \
    --no-install-recommends

# Start a simple command
CMD ["echo", "This is a vulnerable container!"]
