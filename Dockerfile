# Updated & Working Dockerfile for Render

FROM python:3.10-slim-bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Install required system packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        ffmpeg \
        libmagic1 \
        build-essential \
        gcc \
        libffi-dev \
        libssl-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy requirements first (improves caching)
COPY requirements.txt /tmp/requirements.txt

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r /tmp/requirements.txt

# Create work directory
WORKDIR /app
COPY . /app

# Render needs a PORT for health check
ENV PORT=8080

# Start your bot using webserver wrapper (recommended)
CMD ["python3", "bot.py"]

