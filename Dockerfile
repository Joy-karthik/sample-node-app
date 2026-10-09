FROM node:18-alpine@sha256:2e5962c

# Pinned to last known-good revision :29 (image 2e5962c) to halt the
# crash loop caused by building on an EOL node:14-alpine base with
# unpinned, lockfile-less dependency resolution (express "*" -> express@5.2.1
# -> merge-descriptors@2.0.0 requiring Object.hasOwn, Node >=16.9).

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# package-lock.json is required (not optional) for reproducible, pinned installs
COPY package.json package-lock.json .

RUN npm ci --omit=dev

# Bundle app source
COPY . .

EXPOSE 8080

CMD [ "npm", "start" ]
