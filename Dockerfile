# Use Python base image
FROM python:3.8-slim

# Set work directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the DLC logic file into the container
COPY pypi-dlc.py .

# Run the DLC logic script
CMD [ "pypi-dlc.py"]

