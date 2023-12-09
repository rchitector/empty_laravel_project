#!/bin/bash

confirm() {
    local prompt="$1 (y/N): "
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

confirm "Хотите остановить все контейнеры и удалить все образы?" "n"

if [ $? -eq 0 ]; then
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
fi