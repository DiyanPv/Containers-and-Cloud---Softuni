# Use the official Ghost image from Docker Hub
FROM ghost

# Set NODE_ENV to development
ENV NODE_ENV=development

# Expose port 2368 (default Ghost port) inside the container
EXPOSE 2368

# Set up the command to start Ghost
CMD ["node", "current/index.js", "--port", "2368"]

# Configure Docker to listen on port 3001 when accessed from localhost
ENV URL=http://localhost:3001
EXPOSE 3001
