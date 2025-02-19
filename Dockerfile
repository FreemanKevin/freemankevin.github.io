# Build stage
FROM node:18-alpine AS builder

WORKDIR /app
COPY . .

RUN npm install \
    && npm run build

# Runtime stage
FROM nginx:alpine

COPY --from=builder /app/public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 