FROM node:20-alpine

# Gerekli sistem paketleri
RUN apk add --no-cache libc6-compat

WORKDIR /app

# Bağımlılıkları kopyala ve yükle
COPY package*.json ./
RUN npm install --force

# Tüm proje dosyalarını kopyala
COPY . .

# --- TOPLU TAMİR ADIMI ---
# Klasörü temizle/oluştur ve hata veren tüm dosyaları sağlam 1x1 piksellik görsellerle değiştir
RUN mkdir -p public/background-images/ && \
    export DUMMY="iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==" && \
    echo $DUMMY | base64 -d > public/background-images/ali-kazal-tbw_KQE3Cbg-unsplash.jpg && \
    echo $DUMMY | base64 -d > public/background-images/samantha-gades-BlIhVfXbi9s-unsplash.jpg && \
    echo $DUMMY | base64 -d > public/background-images/stephan-louis-y_6S9shS_L0-unsplash.jpg && \
    echo $DUMMY | base64 -d > public/background-images/u_8XvA4P9B8-unsplash.jpg
# ---------------------------

ENV NEXT_TELEMETRY_DISABLED=1
ENV NODE_ENV=development

EXPOSE 3000

# Geliştirme modunda başlat
CMD ["npm", "run", "dev"]
