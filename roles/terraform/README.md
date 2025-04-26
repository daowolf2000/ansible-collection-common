# Роль terraform

Установка terraform используя зеркало

## Особенности работы роли
- По умолчанию используется зеркало Яндекс
- Для указанного пользователя настраивает использование зеркала репозитория (для установки провайдеров)

## Описание параметров

Смотри в [defaults/main.yml](defaults/main.yml)

## Пример использования
```
- name: Install terraform
  hosts: localhost
  become: true
  vars:
    terraform_user: localadmin
    terraform_ver: "1.11.3"

  roles:
    - daowolf2000.common.terraform
```