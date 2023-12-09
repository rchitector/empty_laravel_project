#!/bin/bash

if [[ "$1" == "--project-name="* ]]; then # Парсинг параметра --project-name
    project_name="${1#*=}"

    project_path="$(pwd)/$project_name"

    if [ ! -d "$project_path" ]; then # Проверка существования папки с именем $project_name
        exit 0
    fi

    cd $project_path
    ./vendor/bin/sail up -d
    ./vendor/bin/sail artisan migrate
    cd '..'
fi