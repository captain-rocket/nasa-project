FROM node:lts-alpine

WORKDIR /app

COPY package*.json ./

COPY client/package*.json client/
RUN npm run install-client 

COPY server/package*.json server/
RUN npm run install-server --omit=dev

COPY client/ client/
RUN npm run build --prefix client

RUN npm prune --prefix client --production

COPY server/ server/

USER node

CMD [ "npm", "start", "--prefix", "server"]

EXPOSE 8000

# Ran into and architecture miss match error when tring to turn the docker image on AWS. My Mac is ARM so the image must have built defult ARM. Solution BuildX, https://docs.docker.com/reference/cli/docker/buildx/
# I activated Buildx to enalble mulit-architecture builds. 
# docker buildx create --use
# docker buildx build --platform linux/amd64,linux/arm64 -t username/image-name --push .
# Force to run architecture image
# docker run --platform linux/amd64 --restart=always -p 8000:8000 username/image
# you can also tag 2 sperate images and run explicityly using the tag