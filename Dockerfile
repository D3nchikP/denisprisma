# Use a lightweight base image
FROM alpine:latest

# Set a label for documentation
LABEL maintainer="Denis"

# Add a simple command to show it's working
CMD ["echo", "Hello, Prisma Cloud!"]
