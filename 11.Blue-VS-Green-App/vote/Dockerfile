# Using official python runtime base image
FROM python:3.9-slim

# Set the application directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Make port 80 available to the outside world
EXPOSE 80

# Define the command to run the application
ENTRYPOINT [ "python", "app.py" ]
