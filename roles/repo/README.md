# Роль repo

Добавление/удаление репозитория в debian системах.

## Особенности работы роли
- Поддерживается как создание репозиториев (`present`), так и их удаление (`absent`)
- Описания репозиториев создаются в отдельных файлах в `/etc/apt/sources.list.d/`
- Поддерживается загрузка GPG-ключей для репозиториев
- Поддерживается dearmor для GPG-ключей
- Поддерживаются метаданные для описания репозитория

## Описание параметров

Смотри в [defaults/main.yml](defaults/main.yml)

## Пример использования
```
- name: Add repo for docker
  hosts: localhost
  vars:
    repo_name   : "docker"
    repo_source : "https://download.docker.com/linux/debian bookworm stable"
    repo_meta   : "arch=amd64"
    repo_key_url      : "https://download.docker.com/linux/debian/gpg"
    repo_key_dearmor  : true
  
  roles:
    - daowolf2000.linux.repo
  
  post_tasks:
    - name: Install docker from added repo
      apt:
        name: docker-ce
```

> [!TIP] 
> Данную роль удобно использовать для включения в другие роли. 

```
# Включение в другую роль
- name: Configure repository
  ansible.builtin.include_role:
    name: daowolf2000.linux.repo
  vars:
    repo_name:    "nvidia-conteiner-toolkit"
    repo_source:  'https://nvidia.github.io/libnvidia-container/stable/deb/$(ARCH) /'
    repo_key_url: 'https://nvidia.github.io/libnvidia-container/gpgkey'
    repo_key_dearmor: true

- name: Install package nvidia-container-toolkit
  ansible.builtin.apt:
    name  : nvidia-container-toolkit
    state : present
  become: true
```
