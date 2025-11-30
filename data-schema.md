# Схемы данных

servers.list - список серверов в формате: ip,роль,пользователь,порт
nginx configs - настройки сайтов в /etc/nginx/sites-available/
database - MySQL база с таблицами users, posts, settings
backups - папка /backups/ с архивами по датам
logs - все логи в /var/log/ с ротацией раз в неделю
monitoring - метрики в /var/lib/prometheus/

Директории:
/var/www/ - файлы сайтов
/etc/nginx/ - настройки веб-сервера  
/backups/ - резервные копии
/var/log/ - логи
/home/ - пользовательские данные

Всё остальное - системные файлы, не трогать.
