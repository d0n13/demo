# Use the official Node.js image as the base image
FROM node:23-bookworm

# Set the working directory
WORKDIR /workspace/app

# Copy package.json and package-lock.json
COPY node-login-app/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY node-login-app .