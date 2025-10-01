# Booking Backend (NestJS)

## Prerequisites
- Node.js 20+
- PostgreSQL (local or managed)

## Setup
```bash
cd backend
npm i
npx prisma generate
npx prisma migrate dev --name init
npm run start:dev
```

Health check:
```bash
curl http://localhost:3000/health
```

Docker build:
```bash
docker build -t booking-backend .
```
