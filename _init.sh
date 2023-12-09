#!/bin/bash

confirm() {
    local prompt="$1 (Y/n): "
    local default_choice="${2:-y}"

    read -p "$prompt" -n 1 -r user_response
    echo  # Переход на новую строку

    case "$user_response" in
        [yY])
            return 0  # Возвращаем успешный статус
            ;;
        [nN])
            return 1  # Возвращаем неуспешный статус
            ;;
        *)
            # Возвращаем успешный статус для значения по умолчанию "y"
            [ "$default_choice" == "y" ] && return 0 || return 1
            ;;
    esac
}

project_name=""
if [[ "$1" == "--project-name="* ]]; then # Парсинг параметра --project-name
    project_name="${1#*=}"
fi
while true; do
    if [ -z "$project_name" ]; then
        read -p "Введите имя проекта: " project_name
    else
        if [ -d "$project_name" ]; then # Проверка существования папки с именем $project_name
            echo "Предупреждение: Папка с именем $project_name уже существует."
            project_name=""
        else
           break
        fi
    fi
done

services="none"
if [[ "$2" == "--services="* ]]; then # Парсинг параметра --services
    services="${2#*=}"
    if [[ ! "$services" =~ ^(\"none\"|[a-zA-Z0-9,]+)$ ]]; then # Проверка, что services содержит только буквы, цифры и запятые
        echo "Ошибка: Некорректный формат для параметра --services."
        echo "Доступные сервисы (указывать через запятую): mysql, pgsql, mariadb, redis, memcached, meilisearch, minio, mailpit, selenium, soketi or none"
        exit 1
    fi
fi

echo "Имя проекта: $project_name"
echo "Сервисы: $services"
echo "Доступные сервисы (указывать через запятую): mysql, pgsql, mariadb, redis, memcached, meilisearch, minio, mailpit, selenium, soketi or none"

confirm "Хотите продолжить выполнение скрипта?" "y"

if ! [ $? -eq 0 ]; then
    echo "Процесс отменен."
    exit 0
fi

curl -s "https://laravel.build/$project_name?with=$services" | bash
cd "$(pwd)/$project_name"
sed -i '1i\APP_PORT=8080' .env
sudo chmod -R ugo+rw storage
./vendor/bin/sail up -d

##sleep 5
##./vendor/bin/sail artisan migrate