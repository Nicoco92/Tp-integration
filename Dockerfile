# Étape 1 : Build
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

# Étape 2 : Production
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app ./
# Expose le port de l'application
EXPOSE 3000
CMD ["npm", "start"]