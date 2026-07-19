# --- STAGE 1: Build & Dependencies ---
FROM node:18-alpine AS builder

WORKDIR /usr/src/app

# Copy dependency configurations
COPY package*.json ./

# Install dependencies (including devDependencies if needed for build/lint steps)
RUN npm ci

# Copy backend source files
COPY . .

# --- STAGE 2: Clean Production Environment ---
FROM node:18-alpine AS runner

WORKDIR /usr/src/app

ENV NODE_ENV=production

# Copy only production dependencies and source files from builder stage
COPY package*.json ./
RUN npm ci --only=production

COPY --from=builder /usr/src/app/src ./src

# Expose server port
EXPOSE 5000

CMD ["node", "src/index.js"]
