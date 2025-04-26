# Роль package

Роль предназначена для установки пакетов.

## Особенности работы роли
- Поддержка списков для всех (package_all), группы хостов (package_group) и конкретного хоста (package_host)
- package_all уже содержит список пакетов по умолчанию

## Описание параметров

Смотри в [defaults/main.yml](defaults/main.yml)

## Пример использования
```
- name: Install package
  hosts: localhost
  become: true
  vars:
    package_host:
      - ansbile
      - zabbix-agent

  roles:
    - daowolf2000.common.package
```