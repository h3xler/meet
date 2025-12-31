FROM node:20-alpine

# Gerekli araçları ekle (curl ve kütüphane)
RUN apk add --no-cache libc6-compat curl

WORKDIR /app

# Bağımlılıkları kopyala
COPY package*.json ./

# Bağımlılıkları yükle
RUN npm install --force

# Tüm dosyaları kopyala
COPY . .

# --- KRİTİK ADIM: Bozuk resmi sağlam olanla değiştiriyoruz ---
# Bu komut, bozuk olan unsplash görselini GitHub'daki orijinal sağlam sürümüyle değiştirir.
RUN curl -L -o public/background-images/ali-kazal-tbw_KQE3Cbg-unsplash.jpg \
    "https://raw.githubusercontent.com/livekit/meet/main/public/background-images/ali-kazal-tbw_KQE3Cbg-unsplash.jpg" || true
# -----------------------------------------------------------

ENV NEXT_TELEMETRY_DISABLED=1
ENV NODE_ENV=development

EXPOSE 3000

# Projeyi başlat
CMD ["npm", "run", "dev"]
