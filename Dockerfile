FROM node:14-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json .
# For npm@5 or later, copy package-lock.json as well
# COPY package.json package-lock.json .

# Rollback fix: pin to the healthy build (image tag :29). The previous
# unpinned `npm install` with express: "*" and no package-lock.json let
# builds silently drift onto Express 5.x, whose merge-descriptors@2.x
# calls Object.hasOwn (requires Node >= 16.9) -- causing
# `TypeError: Object.hasOwn is not a function` at app.js:5 on node:14-alpine,
# crash-looping the service before it ever reached listen().
RUN npm install

# Bundle app source
COPY . .

EXPOSE 8080

CMD [ "npm", "start" ]
