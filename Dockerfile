FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# Copy package.json and package-lock.json for reproducible installs
COPY package.json package-lock.json* .

RUN npm ci

# Bundle app source
COPY . .

EXPOSE 8080

CMD [ "npm", "start" ]
