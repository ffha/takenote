# Use small Alpine Linux image
FROM node:lts-alpine

# Set environment variables
ENV PORT=5000
ARG CLIENT_ID

COPY . app/

WORKDIR app/
# Make sure dependencies exist for Webpack loaders
RUN apk add musl-dev libc6-compat libjpeg-turbo-dev libpng-dev make gcc g++ nasm bash
RUN npm ci --only-production --silent

# Build production client side React application
RUN npm run build

# Expose port for Node
EXPOSE $PORT

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["npm", "run", "prod"]
