# Роль repo

Добавление/удаление пользователей по списку.

## Особенности работы роли
- Поддержка списков для всех (user_all), группы хостов (user_group) и конкртеного хоста (user_host)
- Возможность задать uid/gid для пользователя
- Добавление ssh ключей в authorized_keys
- Настройка sudo для пользователя

## Описание параметров

Смотри в [defaults/main.yml](defaults/main.yml)

## Пример использования
```
- name: Test playbook
  hosts: localhost
  become: true
  vars:
    users_host:
      ansible:
        sudo: true
        sudo_nopass: true
      zbx:
        uid: 1995
        gid: 1997
        ssh_auth_keys: "{{ lookup('file', lookup('env', 'HOME') + '/.ssh/id_ed25519.pub') }}"
        sudo: true
        sudo_commands:
          - /usr/bin/systemctl start zabbix-*
          - /usr/bin/systemctl stop zabbix-*
          - /usr/bin/systemctl restart zabbix-*
      test:
        state: absent

  roles:
    - users
```