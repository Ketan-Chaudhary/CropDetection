# ========== Build Stage ==========
FROM node:20.19.3 AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the app including .env
COPY . .

# Build the production React app
RUN npm run build

# ========== Nginx Serve Stage ==========
FROM nginx:alpine

# Copy built static files from builder stage to Nginx web directory
COPY --from=builder /app/dist /usr/share/nginx/html

# Optional: Replace default Nginx config (if needed)
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]