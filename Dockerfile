FROM node:18-alpine AS base

# Install dependencies only when needed
FROM base AS deps

ENV CI true
ENV NODE_ENV production

RUN apk add --no-cache libc6-compat

WORKDIR /app

COPY package.json .
COPY package-lock.json .

RUN npm pkg delete scripts.prepare
RUN npm ci

FROM base AS builder

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN npm run build

FROM nginx:alpine AS runner

WORKDIR /app

RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder ./build /usr/share/nginx/html
COPY --from=builder ./.nginx/nginx.conf /etc/nginx/conf.d/default.conf
RUN touch /var/run/nginx.pid
RUN chown -R nginx:nginx /var/run/nginx.pid /usr/share/nginx/html /var/cache/nginx /var/log/nginx /etc/nginx/conf.d

USER nginx

CMD ["nginx", "-g", "daemon off;"]
