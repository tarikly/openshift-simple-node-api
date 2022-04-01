ARG NODE_VERSION=14

###
# 1. Dependencies
###

FROM node:${NODE_VERSION}-slim as dependencies
WORKDIR /app

RUN apt-get update
RUN apt-get install -y build-essential python
RUN npm install --global npm node-gyp

COPY package.json *package-lock.json *.npmrc ./

ARG NODE_ENV=production
ENV NODE_ENV ${NODE_ENV}
RUN npm ci

###
# 2. Application
###

FROM node:${NODE_VERSION}-slim
WORKDIR /app

COPY --from=dependencies /app/node_modules node_modules
COPY . .

ENV PATH="$PATH:/app/node_modules/.bin"
ENV NODE_ENV production
ENV PORT 8080

EXPOSE 8080

CMD ["node", "."]