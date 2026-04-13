# 1단계: 빌드 스테이지
FROM node:22-alpine AS builder

WORKDIR /app

# 필요한 의존성 설치
RUN apk add --no-cache python3 make g++

# HonKit 및 플러그인 전역 설치 (honkit이 전역 플러그인을 찾을 수 있도록)
RUN npm install -g honkit@3.6.23
RUN npm install -g gitbook-plugin-customize-footer

# 프로젝트 소스 복사
COPY . .

# HonKit 빌드
RUN honkit build

# 2단계: 최종 실행 스테이지
FROM node:22-alpine

WORKDIR /app

# 빌드 결과물만 복사
COPY --from=builder /app/_book /app/_book

# 정적 파일 제공에 필요한 serve 설치
RUN npm install -g serve

# 포트 설정
EXPOSE 4000

# 정적 파일 제공
CMD ["npx", "serve", "/app/_book"]

