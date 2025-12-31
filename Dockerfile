FROM node:20-alpine

# Gerekli sistem paketleri
RUN apk add --no-cache libc6-compat

WORKDIR /app

# Bağımlılıkları kopyala ve yükle
COPY package*.json ./
RUN npm install --force

# Tüm proje dosyalarını kopyala
COPY . .

# --- KRİTİK TAMİR ADIMI ---
# 1. Klasörün var olduğundan emin ol
RUN mkdir -p public/background-images/

# 2. Hata veren dosyayı sil ve yerine 1x1 piksellik sağlam bir görsel oluştur (Base64)
RUN echo "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==" | \
    base64 -d > public/background-images/ali-kazal-tbw_KQE3Cbg-unsplash.jpg
# ---------------------------

ENV NEXT_TELEMETRY_DISABLED=1
ENV NODE_ENV=development

EXPOSE 3000

# Geliştirme modunda başlat
CMD ["npm", "run", "dev"]
