# Ansible Collection - daowolf2000.linux

Моя коллекция для Linux. Роли написаны преимущественно под Debian, работоспособность под другие ОС не гарантируется (если явно не указано обратное).

# Роли

> [!TIP]
> Все используемые параметры ролей подробно описаны в файлах `defaults/main.yml`. Заголовок каждой роли является ссылкой, ведущей на соответствующий `defaults/main.yml`

### [common](roles/common/defaults/main.yml)
Роль с общими переменными и handlers. В ролях где они используются необходимо создать `meta/main.yml` со следующим содержанием:
```
dependencies:
  - daowolf2000.linux.common
```
### [docker](roles/docker/defaults/main.yml)

- Установка и настройка Docker CE 
- Автоматическая установка Nvidia Container Toolkit (при наличии видеокарты Nvidia)
- Добавление указанных пользователей в группу docker

### [hosts](roles//hosts/defaults/main.yml)

- Полностью управляет содержимым файла `/etc/hosts`. Ручное редактирование файла запрещено
- Добавление записей для хостов определенных в словаре
- Списки хостов могут быть определены для всех (hosts_all), группы хостов (hosts_group) и конкретного хоста (hosts_host)
- Добавление записей из Ansible inventory (опционально)
- Проверка записей на дубликаты

### [jupyter](roles/jupyter/defaults/main.yml)

- Установка jupyter с docker образа с помощью docker-compose
- Создается служба systemd для автозапуска и управления приложением
- Поддержка переменных окружения
- Запуск Jupyter server с параметрами
- Добавление пакетов в образ через создание custom образа

### [openwebui](roles/openwebui/defaults/main.yml)

- Установка openwebui с docker образа с помощью docker-compose
- Создается служба systemd для автозапуска и управления приложением
- Поддержка переменных окружения

### [package](roles/package/defaults/main.yml)

- Установка заданного списка пакетов
- Поддержка списков для всех (package_all), группы хостов (package_group) и конкретного хоста (package_host)
- package_all уже содержит список пакетов по умолчанию

### [repo](roles/repo/README.md)

- Добавление/удаление репозитория в debian системах.
- Поддерживается как создание репозиториев (`present`), так и их удаление (`absent`)
- Описания репозиториев создаются в отдельных файлах в `/etc/apt/sources.list.d/`
- Поддерживается загрузка GPG-ключей и их dearmor
- Поддерживаются метаданные для описания репозитория
- Удобно использовать в других ролях через `include_role`

### [terraform](roles/terraform/defaults/main.yml)

- Установка terraform используя зеркало Яндекс
- Настройка зеркала для установки провайдеров 

### [users](roles/users/defaults/main.yml)

- Создание и настройка пользователей
- Поддержка списков для всех (user_all), группы хостов (user_group) и конкртеного хоста (user_host)
- Возможность задать uid/gid для пользователя
- Добавление ssh ключей в authorized_keys
- Настройка sudo для пользователя

### x

Набор задач-функций для использования в других ролях

### [zabbix_agent](roles/zabbix_agent/defaults/main.yml)

- Установка и настройка zabbix-agent