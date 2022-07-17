# Use small Alpine Linux image
FROM node:lts-alpine

# Set environment variables
ENV PORT=5000
ARG CLIENT_ID

COPY . app/

WORKDIR app/
RUN rm package-lock.json
# Make sure dependencies exist for Webpack loaders
RUN apk add build-base nasm autoconf automake
RUN yarn

# Build production client side React application
RUN yarn build

# Expose port for Node
EXPOSE $PORT

ENTRYPOINT ["/sbin/tini", "--"]
ENTRYPOINT ["npm", "run", "prod"]
