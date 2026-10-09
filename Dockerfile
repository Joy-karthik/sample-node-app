FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# Copy package.json and package-lock.json for reproducible installs
COPY package.json package-lock.json* ./

# Use `npm ci` instead of `npm install`: it requires package-lock.json and
# installs exact pinned dependency versions, preventing a floating version
# range (e.g. express: "*") from silently re-resolving to an incompatible
# major version during the image build.
RUN npm ci --omit=dev

# Bundle app source
COPY . .

EXPOSE 8080

CMD [ "npm", "start" ]
