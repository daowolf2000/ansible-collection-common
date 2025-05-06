network:
- Включение ip_forwarding
- Настройка DNS
- Переименование хоста

- Настройка синхронизации времени


- Настройка параметров sshd

DNS:
- Роль для установки DNS-сервера (BIND9)
- Настройки клиентов для авторегистрации на DNS сервере

Окружение:
- Настройка .bashrc, .profile
- Настройки tmux

User:
- Установка authorized keys
- Генерация сертификатов ssh



- Настройка LVM
- Настройка NFS сервера
- Настройка NFS клиента

- Настройка git
- Клонирование git репозиториев

- Настройка кластера Kubernetes

Установка приложений:
- Graphana
- Zabbix
- Prometeus
- PostgreSQL
- PGAdmin
- Jenkis
- etcd
- nginx
- haproxy
- seafile
- comfyui
- apache superset


- RabbitMQ
- MQTT



- name: Disable SSH password login
  ansible.builtin.lineinfile:
    dest: /etc/ssh/sshd_config
    regexp: "^PasswordAuthentication"
    line: "PasswordAuthentication no"
  notify: Restart sshd

- name: Fix /etc/sudoers.d permissions
  ansible.builtin.file:
    path: /etc/sudoers.d
    state: directory
    mode: "0750"