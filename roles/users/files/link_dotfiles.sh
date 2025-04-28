#!/bin/bash

# Получаем путь к каталогу, где находится сам скрипт
if [ -n "$1" ]; then
    SOURCE_DIR="$1"
else
    SOURCE_DIR="$(dirname "$(realpath "$0")")"
fi


# Определяем домашний каталог: либо передаётся первым аргументом, либо берём текущий домашний каталог
if [ -n "$2" ]; then
    DEST_DIR="$2"
else
    DEST_DIR="$HOME"
fi


BACKUP_DIR="${DEST_DIR}/.backup"
mkdir -p "$BACKUP_DIR"

# Функция перемещения существующего файла в BACKUP_DIR
backup_file() {
    local src="$1"
    local rel_path="${src#$DEST_DIR/}"  # получаем относительный путь от SOURCE_DIR
    local backup_path="$BACKUP_DIR/$rel_path"
    local backup_dirname=$(dirname "$backup_path")
    
    # Создаем промежуточные директории в BACKUP_DIR, если они отсутствуют
    mkdir -p "$backup_dirname"
    
    mv "$src" "$backup_path"
    echo "BACKUP:  $src -> $backup_path"
}

# Обходим рекурсивно директорию SOURCE_DIR
find "$SOURCE_DIR" -type f -iname "*" | grep -Ev "$SOURCE_DIR/(\.git\/|\.gitignore|README\.md|link_dotfiles\.sh)" |  while read file_path; do
    # Относительный путь от SOURCE_DIR
    relative_path="${file_path#$SOURCE_DIR/}"
    
    # Путь назначения внутри DEST_DIR
    dest_dir="$DEST_DIR/$relative_path"
    dest_dirname=$(dirname "$dest_dir")
    
    # Перемещаем файл в резервную копию, если он существует и не является ссылкой
    if [[ ! -L "$dest_dir" && -e "$dest_dir" ]]; then
        backup_file "$dest_dir"
    fi
    
    # Создаем промежуточные директории, если они отсутствуют
    mkdir -p "$dest_dirname"
    
    # Проверка существования символической ссылки
    if [[ ! -L "$dest_dir" || $(readlink "$dest_dir") != "$file_path" ]]; then
        # Создание новой символической ссылки
        ln -sf "$file_path" "$dest_dir"
        echo "LINK:   $dest_dir -> $file_path"
    else
        echo "PASS:   $dest_dir -> $file_path"
    fi
done
