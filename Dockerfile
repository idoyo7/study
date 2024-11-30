# Node.js 최신 LTS 버전인 18 버전을 사용합니다.
FROM node:18

# 작업 디렉토리를 설정합니다.
WORKDIR /app

# HonKit을 글로벌로 설치합니다.
RUN npm install -g honkit

# 현재 디렉토리의 내용을 컨테이너로 복사합니다.
COPY . /app

# 포트 설정
EXPOSE 4000

# GitBook을 빌드하고 서버를 실행합니다.
CMD ["honkit", "serve"]

