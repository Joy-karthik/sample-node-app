FROM node:18.20-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# Copy package.json (and package-lock.json if present) for reproducible installs
COPY package.json package-lock.json* ./

# Ensure a lockfile exists so dependency resolution is pinned and
# reproducible, then install strictly from it. This prevents floating
# version ranges (e.g. express/morgan "*") from silently re-resolving
# to incompatible majors on rebuild.
RUN if [ ! -f package-lock.json ]; then npm install --package-lock-only; fi \
    && npm ci --omit=dev

# Bundle app source
COPY . .

EXPOSE 8080

CMD [ "npm", "start" ]
