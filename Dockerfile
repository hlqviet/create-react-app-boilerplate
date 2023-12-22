FROM node:18-alpine AS build

ENV CI true
ENV NODE_ENV production

WORKDIR /app

COPY package*.json .

RUN npm pkg delete scripts.prepare
RUN npm ci

COPY . .

RUN npm run build

FROM nginx:alpine

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*
COPY --from=build /app/build .
COPY --from=build /app/.nginx/nginx.conf /etc/nginx/conf.d/default.conf
