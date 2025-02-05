# Use a base image with the desired version of Node.js
FROM node:22

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Install DLC command-line tool
RUN npm install -g discreetlogcontracts

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port on which the DLC application will run
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]

