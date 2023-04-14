# Use the official Node.js 16 image as the base image
FROM node:16 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application code to the working directory
COPY . .

# Build the production version of the application
RUN npm run build

# Use the official Node.js 16 image for the runtime environment
FROM node:16 AS runtime

# Set the working directory
WORKDIR /app

# Copy the build output from the build stage
COPY --from=build /app/build /app/build

# Install serve to serve the application
RUN npm install -g serve

# Expose the port that the application will run on
EXPOSE 5000

# Start the application
CMD ["serve", "-s", "build", "-l", "5000"]
