# Really simple Dockerfile to build a react production container which listens on port $PORT

FROM node:14-alpine

EXPOSE $PORT

WORKDIR /usr/src/app

COPY package*.json ./
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh
RUN yarn install
COPY . .
RUN yarn build

CMD [ "sh", "-c", "yarn serve" ]
