# Use the official ROS 2 Humble base image
FROM ros:humble

# Set the locale
RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

# Set environment variables
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg2 \
    git \
    build-essential \
    libgtk-3-dev \
    libx11-dev \
    && rm -rf /var/lib/apt/lists/*

# Install code-server for a web-based version of VS Code
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Set up workspace
RUN mkdir -p /workspace
WORKDIR /workspace

# Expose ports for code-server
EXPOSE 8080

# Start code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "/workspace"]
