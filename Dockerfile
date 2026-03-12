FROM pytorch/pytorch:2.9.1-cuda12.8-cudnn9-runtime

# Set environment variables for non-interactive installation.
ENV DEBIAN_FRONTEND=noninteractive

# Upgrade pip first.
RUN pip install --upgrade pip

# Install THIS repository's version of MIST into the image (includes latest CLI flags).
# Copy only what's needed to build the package to leverage Docker layer caching.
WORKDIR /src/mist
COPY pyproject.toml setup.py README.md ./
COPY mist ./mist

# Install local package (builds from pyproject.toml/setup.py).
RUN pip install --no-cache-dir .

# Create app directory for runtime outputs/workdir.
RUN mkdir -p /app
WORKDIR /app
