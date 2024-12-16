# 1단계: 빌드 스테이지
FROM node:18-alpine AS builder

WORKDIR /app

# 필요한 의존성 설치
RUN apk add --no-cache python3 make g++

# HonKit 및 플러그인 설치
RUN npm install -g honkit
RUN npm install -g honkit gitbook-plugin-customize-footer
RUN npm install gitbook-plugin-customize-footer --save

# 프로젝트 소스 복사
COPY . .

# HonKit 빌드
RUN honkit build

# 2단계: 최종 실행 스테이지
FROM node:18-alpine

WORKDIR /app

# 빌드 결과물만 복사
COPY --from=builder /app/_book /app/_book

# 정적 파일 제공에 필요한 serve 설치
RUN npm install -g serve

# 포트 설정
EXPOSE 4000

# 정적 파일 제공
CMD ["npx", "serve", "/app/_book"]

