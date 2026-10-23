FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json package-lock.json* .

RUN npm ci

# Bundle app source
COPY . .

EXPOSE 8080

CMD [ "npm", "start" ]
