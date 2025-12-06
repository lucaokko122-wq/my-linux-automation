#!/bin/bash
# Проверка зависимостей перед установкой

echo "🔍 Проверка системных зависимостей..."

# Проверяем ОС
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "ОС: $NAME $VERSION"
else
    echo "Не удалось определить ОС"
    exit 1
fi

# Проверяем версию bash
bash_version=$(bash --version | head -n1 | awk '{print $4}')
echo "Bash версия: $bash_version"

# Проверяем наличие обязательных пакетов
required_packages=("git" "curl" "wget" "ssh" "sudo")

for pkg in "${required_packages[@]}"; do
    if command -v $pkg &> /dev/null; then
        echo "$pkg установлен"
    else
        echo "$pkg не установлен"
        echo "Установите: sudo apt install $pkg"
    fi
done

# Проверяем права
if [ "$EUID" -eq 0 ]; then
    echo "Запуск от root - не рекомендуется"
fi

echo ""
echo "✅ Проверка завершена"
