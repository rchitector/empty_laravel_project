## Список команд
#### запустить докер, если не запущен
```
./_start_docker.sh
```
#### собрать новый проект в папке "my_project_name"
```
./_init.sh --project-name=my_project_name --services=pgsql,soketi
```
#### запустить проект "my_project_name"
```
./_start.sh --project-name=my_project_name
```
#### остановить проект "my_project_name"
```
./_stop.sh --project-name=my_project_name
```
#### перезапустить проект "my_project_name"
```
./_restart.sh --project-name=my_project_name
```
#### остановить докер 
```
./_stop_docker.sh
```
## ВНИМАНИЕ!!! 
#### остановить ВСЕ контейнеры и удалить ВСЕ образы из системы
#### выполнять эту команду на свой страх и риск
```
./_drop.sh
```