astra-basic
=========

Роль для настройки базовых параметров ОС Astra Linux Special Edition "Смоленск":
- Имя сервера
- Сетевые настройки (hosts и resolv)
- Установка базовых пакетов

Переменные
--------------

domain_full - Полное наименование домена (default: region.cbr.ru)
dns_ip      - Список IP-адресов DNS серверов (default: 127.0.0.1, 127.0.1.1)

Пример playbook
----------------
  - hosts: all
    roles:
    - { role: astra, when: ansible_os_family == 'Astra Linux' }
