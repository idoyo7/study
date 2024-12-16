# 1단계: 빌드 스테이지
FROM node:18-alpine AS builder

WORKDIR /app

# 필요한 의존성 설치
RUN apk add --no-cache python3 make g++

# 의존성 설치 및 빌드
COPY package*.json ./
RUN npm install

# HonKit 설치 및 빌드
RUN npm install -g honkit
COPY . .
RUN honkit build

# 2단계: 최종 실행 스테이지
FROM node:18-alpine

WORKDIR /app

# 빌드 결과물만 복사
COPY --from=builder /app/_book /app/_book

# 포트 설정
EXPOSE 4000

# 정적 파일 제공
CMD ["npx", "serve", "/app/_book"]

