# Базовый образ
FROM ubuntu:20.04

# Неинтерактивная установка
ENV DEBIAN_FRONTEND=noninteractive

# Обновление и установка пакетов
RUN apt-get update && apt-get install -y \
    nginx \
    python3 \
    python3-pip \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Копируем скрипты из репозитория
COPY scripts/ /opt/scripts/

# Копируем конфиги
COPY configs/nginx/default /etc/nginx/sites-available/default

# Рабочая директория
WORKDIR /app

# Копируем приложение (если будет)
COPY app/ ./

# Открываем порты
EXPOSE 80 443

# Запускаем сервисы
CMD ["sh", "-c", "nginx -g 'daemon off;' & python3 /opt/scripts/web-server.sh"]
